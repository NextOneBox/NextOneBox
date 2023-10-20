const express = require('express');
const router = express.Router();

const Winners = require('./userSchema');


router.get('/', async (req, res) => {
    try {
      const topBalanceList = await User.find({})
        .sort({ Balance: -1 }) // Sort by 'Balance' field in descending order
        .limit(20); // Limit the result to 20 records
  
      res.json(topBalanceList);
    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });
  


module.exports = router;
