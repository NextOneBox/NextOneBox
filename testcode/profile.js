const express = require('express');
const router = express.Router();

const User = require('./userSceama');


// API route to get user profile data
router.get('/:email', async (req, res) => {
  try {
    const userEmail = req.params.email;
    const userProfile = await User.findById(userEmail)
    res.json(userProfile);
  } catch (err) {
    res.status(500).json({ message: 'Server Error' });
  }
});

router.put('/', (req, res) => {
    const { email } = req.body;
    
    // Find the user and update the profile data
    User.findOneAndUpdate(
        { email: email }, // Match the user based on the username or any other unique identifier
        req.body, // Use the entire req.body object as the update data
        { new: true } // Return the updated user object
    )
        .then(updatedUser => {
        res.json(updatedUser);
        })
        .catch(error => {
        res.status(500).json({ message: 'Failed to update profile' });
        });
    });
    
    


router.post('/:otp', async (req, res) => {
    const otp = req.params.otp;
    const {email} = req.body;
    const existingUser = await User.findById(email)
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
  
  

module.exports = router;
