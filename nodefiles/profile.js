const express = require('express');
const router = express.Router();

const User = require('./userSceama');


// API route to get user profile data
router.get('/:id', async (req, res) => {
  try {
    const userId = req.params.id;
    const userProfile = await User.findById(userId)
      .select('-followers') 
      .select('-following') 
    const followers = await User.findById(userId).select('followers');
    const following = await User.findById(userId).select('following');
    const followingCount = following.followers.length;
    const followersCount = followers.followers.length;
    console.log(followersCount,followingCount);
    res.json(userProfile,followersCount,followingCount);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server Error' });
  }
});

  
  module.exports = router;
