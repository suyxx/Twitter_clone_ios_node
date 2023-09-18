const express = require('express');

const auth = require('../middleware/auth');
const Notification = require('../models/notification');

const router = new express.Router();

router.post('/notification', auth ,async (req, res) => {
    const notification = new Notification({
        ...req.body,
        user: req.user._id
    })

    try{
        await notification.save();
        res.status(201).send(notification);

    }catch(err){
        res.status(400).send(err)
    }
})

router.get('/notification' ,async (req, res) => {
    try{
        const notification = await Notification.find({})
        res.status(200).send(notification)
    }catch(err){
        res.status(500).send(err);
    }
})

router.get('/notification/:id' ,async (req, res) => {
    try{
        const _id = req.params.id;
        const notification = await Notification.find({notReceiverId: _id});
        res.status(200).send(notification)
    }catch(err){
        res.status(500).send(err);
    }
})

module.exports = router;