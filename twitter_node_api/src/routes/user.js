const express = require('express');
const User = require('../models/user');
const multer = require('multer');
const sharp = require('sharp');
const auth = require('../middleware/auth');

const router = new express.Router();

// Helpers

const upload = multer({
    limits: {
        fileSize : 1000000
        
    }
})

router.post('/users', async (req, res) => {
    const user = new User(req.body)
    try {
        await user.save()
        res.status(200).send(user)
    }catch (err) {
        res.status(400).send(err)
    }
})

router.get('/users', async (req, res) => {
    try {
        const users = await User.find({})
        res.status(200).send(users)
    }catch (err) {
        res.status(500).send(err)
    }

})

// login user router

router.post('/users/login', async (req, res) => {
    try{
        const user = await User.findByCredentials(req.body.email, req.body.password)
        const token = await user.generateAuthToken()

        res.status(200).send({user, token})
    }catch (err) {
        res.status(500).send(err)
    }
})

// Delete user route

router.delete('/users/:id', async (req, res) => {
    try{
        const user = await User.findByIdAndDelete(req.params.id)
        if(!user){
        return res.status(404).send()
        }

        res.send()
    }catch (err) {
        res.status(500).send(err)
    }
})

// Fetch single user

router.get('/users/:id', async (req, res) => {
    try{
        const user = await User.findById(req.params.id)
        if(!user){
            return res.status(404).send()
        }
        res.status(200).send(user)
    }catch (err) {
        res.status(500).send(err)
    }
})

// Post User Profile Image

router.post('/users/me/avatar',auth ,upload.single('avatar'), async (req, res) => {
    const buffer = await sharp(req.file.buffer).resize({width: 250, height: 250}).png().toBuffer()
    if(req.user.avatar != null){
        req.user.avatar = null
    }

    req.user.avatar = buffer
    req.user.avatarExists = true
    await req.user.save()
    res.send(buffer)
}, (err, req, res) => {
    res.status(400).send({error: err.message})
})

router.get('/users/:id/avatar', async (req, res) => {
    try{
        const user = await User.findById(req.params.id)
        if(!user || !user.avatar){
            throw new Error('The user does not exist')
        }

        res.set('Content-Type', 'image/jpg')
        res.status(200).send(user.avatar)
    }catch(err){
        res.status(404).send(err)
    }
})

// Route for following

router.put('/users/:id/follow',auth, async (req, res) => {
    console.log("follow called")
    console.log(req.user.id)
    console.log(req.params.id)
    if(req.user.id != req.params.id){
        try{
            const user = await User.findById(req.params.id)
            if(!user.followers.includes(req.user.id)){
                await user.updateOne({ $push: { followers: req.user.id}})
                await req.user.updateOne({ $push: { following : req.user.id }})
                console.log("followed")
                res.status(200).json('Followed')
            }
            else{
                res.status(403).json('Already Followed')
            }
        }catch(err){
            res.status(500).json(err)
        }
    }else{
        res.status(403).json('Can not follow self')
    }
})

router.put('/users/:id/unfollow',auth, async (req, res) => {
    console.log("unfollow called")
    console.log(req.user.id)
    console.log(req.params.id)
    if(req.user.id != req.params.id){
        try{
            const user = await User.findById(req.params.id)
            if(user.followers.includes(req.user.id)){
                await user.updateOne({ $pull: { followers: req.user.id}})
                await req.user.updateOne({ $pull: { following: req.user.id}})
                console.log("unfollowed")
                res.status(200).json('Unfollowed')
            }
            else{
                res.status(403).json('Already Not Following')
            }
        }catch(err){
            res.status(500).json(err)
        }
    }else{
        res.status(403).json('Can not unfollow self')
    }
})

router.patch('/users/:id', auth ,async (req, res) => {
    
    try{
        console.log("patch called")
        const updates = Object.keys(req.body)
        console.log(updates)
        const allowedUpdates = ['name', 'email', 'password', 'website', 'bio', 'location']
        const isValidOperation = updates.every((update) => allowedUpdates.includes(update))
        if (!isValidOperation){
            console.log('Invalid operation')
            return res.status(400).send({
                error: 'Invalid operation'
            })
        }

        const user = req.user
        console.log(req.body['name'])
        console.log(user['website'])
        updates.forEach((update) => {user[update] = req.body[update]})
        await user.save()
        console.log(user['website'])
        console.log(user)
        res.status(200).send(user)
    }catch (err) {
        res.status(400).send(err)
    }
})

module.exports = router