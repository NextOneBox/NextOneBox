const mongoose = require('mongoose');


const user = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true
  },
  name: {
    type: String,
    required: true
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
  upi: {
    type: String
  },
  adress: {
    type: String
  },
    shops: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Shop'
  }],
  services: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Service'
  }],
  liked: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Shop'
  }],
  rating: [{
    user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User'
    },
    rate: {
      type: Number,
      default: 0
    },

  }],
});


const User = mongoose.model('User', user);


module.exports =  User;

