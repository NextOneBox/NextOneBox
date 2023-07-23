const mongoose = require('mongoose');


const shop = new mongoose.Schema({
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
  delivery: {
    type: String
  },
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

  rating: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  }],
   products: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Product'
  }],
  owner: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  },
});


const Shop = mongoose.model('Shop', shop);


module.exports =  Shop;

