const mongoose = require('mongoose');
const validator = require('validator');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');


const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    username: {
        type: String,
        required: true,
        trim: true,
        unique: true
    },
    email: {
        type: String,
        unique: true,
        required: true,
        trim: true,
        lowercase: true,
        validate(value){
           if (!validator.isEmail(value)){
                throw new Error('Invalid email')
           }
        }
    },

    password: {
        type: String,
        required: true,
        minLength: 7,
        trim: true,
        validate(value){
            if (value.toLowerCase().includes('password')){
                throw new Error('Password can not contain "password" ')
            }
        }
    },
    tokens: [{
        token: {
            type: String,
            required: true,
        }
    }],
    avatar: {
        type: Buffer,
    },
    avaterExists: {
        type: Boolean,
    },
    bio: {
        type: String,
    },
    location: {
        type: String,
    },
    website: {
        type: String,
    },
    followers: {
        type: Array,
        default: []
    },
    following: {
        type: Array,
        default: []
    }
})

// to delete password in response
userSchema.methods.toJSON = function(){
     const user = this
     const userObject = user.toObject()
     delete userObject.password
     return userObject
}

userSchema.pre('save', async function(next){
    const user = this
    
    if (user.isModified('password')){
        user.password = await bcrypt.hash(user.password, 8)
    }
    next()
})



// the relationship between tweet and user

userSchema.virtual('tweets', {
    ref: 'Tweet',
    localField: '_id',
    foreignField: 'user'
})

userSchema.virtual('notificationSent', {
    ref: 'Notification',
    localField: '_id',
    foreignField: 'notSenderId'
})

userSchema.virtual('notificationReceived', {
    ref: 'Notification',
    localField: '_id',
    foreignField: 'notReceiverId'
})

// create tokens

userSchema.methods.generateAuthToken = async function(){
    const user = this
    const token  = jwt.sign({_id: user._id.toString() }, 'twitter-oauth-token')
    user.tokens = user.tokens.concat({token})
    await user.save()
    return token
}

//authentication check function

userSchema.statics.findByCredentials = async (email, password) => {
    const user = await User.findOne({ email})
    if(!user){
        throw new Error('Unable to find user')
    }
    const isMatch =  await bcrypt.compare(password, user.password)

    if(!isMatch) {
        throw new Error('Unable to login to Twitter')
    }

    return user

}

const User = mongoose.model('User', userSchema)

module.exports = User