const mongoose = require('mongoose');

// User Schema
const userSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true
  },
  name: {
    type: String,
    required: true
  },
  bio: {
    type: String
  },
  profileImage: {
    type: String
  },
  email: {
    type: String,
    required: true,
    unique: true
  },
  createdAt: {
    type: Date,
    default: Date.now
  },
  gender: {
    type: String
  },
  birth: {
    type: Date
  },
  phone: {
    type: String
  },
  topic:  [{
    type: String,
    required: true
  }],
  followers: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  }],
  following: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  }],
  watched: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'VideoPost'
  }],
  liked: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'VideoPost'
  }]
});


const User = mongoose.model('User', userSchema);


module.exports =  User;

