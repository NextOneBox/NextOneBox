const express = require('express');
const router = express.Router();

const User = require('./userSceama');


// API route to get user profile data
router.get('/:id', async (req, res) => {
  try {
    const userId = req.params.id;
    const userProfile = await User.findById(userId)
    .populate('following', 'username','profileImage') 
    .populate('followers', 'username','profileImage') 
    res.json(userProfile);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server Error' });
  }
});

  
  module.exports = router;
