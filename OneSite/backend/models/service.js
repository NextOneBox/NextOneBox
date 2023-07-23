const mongoose = require('mongoose');

const service = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true
  },
  name: {
    type: String,
    required: true
  },
  description: {
    type: String
  },
  profileImage: {
    type: String
  },
  timing: {
    type: String
  },
  price: [{

    price: {
      type: String,
    },
    name: {
        type: String,
      },
  }],
  type: {
    type: String
  },
  contact: {
    type: String,
  },
  createdAt: {
    type: Date,
    default: Date.now
  },
  views: {
    type: Number,
    default: 0
  },
  adress: {
    type: String
  },
  owner: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  },

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


const Service = mongoose.model('Service', service);


module.exports =  Service;

