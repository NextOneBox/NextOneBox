const express = require('express');
const router = express.Router();

const User = require('./userSceama');


// API route to get user profile data
router.get('/:id', async (req, res) => {
  try {
    // Assuming you have authentication middleware to get the authenticated user
    const userId = req.params.id;
   
    const userProfile = await User.findById(userId)
      .populate('following', 'username') // Populate followers with only username field
      .populate('followers', 'username') // Populate following with only username field
      // .populate('posts', 'title'); 
    const usere = await User.findById(userId).select('followers');
    const followersCount = usere.followers.length;
    console.log(followersCount);
    res.json(userProfile);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server Error' });
  }
});

  
  module.exports = router;
