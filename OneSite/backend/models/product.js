const mongoose = require('mongoose');
const shop = new mongoose.Schema({
  shop:{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Shop'
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

  type: {
    type: String
  },

  createdAt: {
    type: Date,
    default: Date.now
  },
  views: {
    type: Number,
    default: 0
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


const Shop = mongoose.model('Shop', shop);


module.exports =  Shop;

