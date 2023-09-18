const User = require('../models/user')
const jwt = require('jsonwebtoken');
const config = require('config');

const auth = async (req, res, next) => {
  const token = req.header('Authorization')?.replace('Bearer ', '');
  const privateKey = 'twitter-oauth-token'; 
  console.log('Auth header:', req.header('Authorization'));
  console.log('Token:', token);
  if (!token) {
    return res.status(401).json({ msg: 'No token, authorization denied' });
  }

  try {
    const decoded = jwt.verify(token, privateKey);

    const user = await User.findOne({_id: decoded._id, 'tokens.token': token})
        console.log(user)
        if (!user) {
            throw new Error('User not found')
        }

    req.token = token;
    req.user = user;
    next();
  } catch (err) {
    console.error('JWT error:', err);
    return res.status(401).json({ msg: 'Token is not valid' });
  }
};

module.exports = auth;
