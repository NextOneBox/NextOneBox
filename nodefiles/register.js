const express = require('express');
const router = express.Router();
const multer = require('multer');
const storage = multer.memoryStorage()
const upload = multer({ storage: storage })
const User = require('./userSceama');
const SaveOtp = require('./otp');
const nodemailer = require('nodemailer');
const crypto = require('crypto');
const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");
const s3Client = new S3Client({
  region: "ap-south-1",
  credentials: {
    accessKeyId: "AKIAS6YXFLWYR3DTIP37",
    secretAccessKey: "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",
  },
});

const { models } = require('mongoose');
const { route } = require('./uploadVideo');

const transporter = nodemailer.createTransport({
  host: 'smtpout.secureserver.net',
  port: 587,
  secure: false, 
  auth: {
    user: 'info@nextonebox.com',
    pass: '@Shahidmir#8082'
  }
});


router.post('/:otp', async (req, res) => {
  const otp = req.params.otp;
  const { username, name, bio, profileImage, email, gender, birth, phone, topic } = req.body;
  const existingUser = await User.find().or([{ username }, { email }]);
  if (otp == 'google'){
    try {
      if (existingUser.length > 0) {
        return res.status(409).json({ message: 'Login' });
      }
      const newUser = new User(req.body);
      const savedUser = await newUser.save();
      res.json(savedUser);
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: 'Server Error' });
    }

  }else{
    if (otp == 'empty'){

      function generateOTP(length) {
        const otp = crypto.randomBytes(Math.ceil(length / 2)).toString('hex');
        return otp.slice(0, length);
      }
  
      const generatedOTP = generateOTP(6);
    
      const newUser = new SaveOtp({email:email,otp:generatedOTP});
      const savedUser = await newUser.save();
      const mailOptions = {
        from: 'info@nextonebox.com',
        to: email,
        subject: 'Otp for login',
        text: 'Please dont share this otp to any one.'+ generatedOTP 
      };
      
      transporter.sendMail(mailOptions, function(error, info) {
        if (error) {
          console.error(error);
        } else {
          console.log('Email sent: ' + info.response);
        }
      });
      return res.status(409).json({ message: 'otp send' });

    }else{

      const existingOtp = await SaveOtp.find().or([{ email }, { otp }]);
      if (existingOtp.length > 0) {

        if (existingUser.length > 0) {
          return res.status(409).json({ message: 'Login' });
        }
        const newUser = new User(req.body);
        const savedUser = await newUser.save();
        res.json('don');

      }
    
      return res.status(409).json({ message: 'please enter correct otp' });

    };

  }

  });


router.put('/', (req, res) => {
const { username } = req.body;

// Find the user and update the profile data
User.findOneAndUpdate(
    { username: username }, // Match the user based on the username or any other unique identifier
    req.body, // Use the entire req.body object as the update data
    { new: true } // Return the updated user object
)
    .then(updatedUser => {
    // Handle the updated user object
    res.json(updatedUser);
    })
    .catch(error => {
    // Handle any errors
    res.status(500).json({ message: 'Failed to update profile' });
    });
});


  
  module.exports = router;
