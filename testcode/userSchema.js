// user.js
const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  ID: { type: String, required: true },
  Name: { type: String,  default: 'user'},
  Email: { type: String, required: true },
  Balance: { type: Number, default: 0 },
  CreatedAt: {
    type: Date,
    default: Date.now
  },
  PhoneNumber: { type: String },
  Age: { type: String },
  ReferList:  [{
    type: String,
    required: true
  }],
  WithdrawList:  [{
    type: String,
    required: true
  }],
  Account: { type: String },
  ReferCode: { type: String },
  Completed: { type: Boolean, default: false },
  EMPremium: { type: Boolean, default: false },
  LuckeySpin: { type: Number, default: 0 },
  SuperSpin: {type: Boolean, default: false  },
  Course: { type: Boolean, default: false  },
});

// Create and export the User model
module.exports = mongoose.model('User', userSchema);
