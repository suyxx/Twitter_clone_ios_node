const express = require('express');
const Tweet = require('../models/Tweet');
const multer = require('multer');
const sharp = require('sharp');

// new router
const router = new express.Router();

const auth = require('../middleware/auth')

//helper functions

const upload = multer({
    limits: {
        fileSize: 999999999999
    }
})

// post tweets router

router.post('/tweets',auth, async (req, res) => {
    const tweet = new Tweet({
        ...req.body,
        user: req.user._id
    })

    try{
        await tweet.save()
        res.status(201).send(tweet)
    }catch(e){
        res.status(400).send(e)
    }
})

router.post('/uploadTweetImage/:id', auth, upload.single('upload'), async (req, res) => {
    
    console.log("upload image called")
    const tweet = await Tweet.findOne({_id: req.params.id})
    if(!tweet){
        throw new Error('Can not find tweet')
    }

    if(req.file == null){
        throw new Error('File not found');
    }

    const buffer = await sharp(req.file.buffer).resize({width: 350, height: 350}).png().toBuffer()
    tweet.image = buffer
    await tweet.save()
    res.status(200).send()

}, (err, req, res, next) => {
    console.log(err);
    res.status(400).send({error: err.message})
})

router.get('/tweets/:id/image', async (req, res, next) => {
    try{
        const tweet = await Tweet.findById(req.params.id)
        if(!tweet && !tweet.image){
            throw new Error('Tweet image not found')
        }
        res.set('Content-Type', 'image/jpg')
        res.status(200).send(tweet.image)
    }catch(e){
        res.status(404).send(e)
    }
})

//fetch tweets
router.get('/tweets', async (req, res) => {
    try{
        const tweets = await Tweet.find({})
        res.status(200).send(tweets)
    }catch(e){
        res.status(500).send(e)
    }
})

// fetch tweet by user id
router.get('/tweets/:id', async (req, res) => {
    try{
        const _id = req.params.id
        console.log("fetch tweet by user called")
        const tweets = await Tweet.find({user: _id})
        if(!tweets){
            return res.status(404).send()
        }
        res.status(200).send(tweets)
    }catch(e){
        console.log(e)
        res.status(500).send(e)
    }
})

// like tweets

router.put('/tweets/:id/like', auth, async (req, res) => {
    try{
        const tweet = await Tweet.findById(req.params.id)
        if(!tweet.likes.includes(req.user.id)){
            await tweet.updateOne({ $push: {likes: req.user.id}})
            res.status(200).json("post has been liked")
        }else{
            res.status(403).json("you have already liked this tweet")
        }
    }catch(e){
        res.status(500).json(e)
    }
})

// unlike tweet

router.put('/tweets/:id/unlike', auth, async (req, res) => {
    try{
        const tweet = await Tweet.findById(req.params.id)
        if(tweet.likes.includes(req.user.id)){
            await tweet.updateOne({ $pull: {likes: req.user.id}})
            res.status(200).json("post has been unliked")
        }else{
            res.status(403).json("you have not liked this tweet")
        }
    }catch(e){
        res.status(500).json(e)
    }
})

module.exports = router