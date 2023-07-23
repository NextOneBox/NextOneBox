const mongoose = require('mongoose');

// User Schema
const OtpSce = new mongoose.Schema({
  email: {
    type: String,
    required: true,
    unique: true
  },
  otp: {
    type: String,
    required: true
  },
 
});


const SaveOtp = mongoose.model('SaveOtp', OtpSce);


module.exports =  SaveOtp;

