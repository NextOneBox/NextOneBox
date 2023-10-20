const express = require('express');
const router = express.Router();

const Task = require('./TaskSchema');


// API route to get user profile data
router.get('/', async (req, res) => {
  try {
    res.json(Task);
  } catch (err) {
    res.status(500).json({ message: 'Server Error' });
  }
});


  
  

module.exports = router;
