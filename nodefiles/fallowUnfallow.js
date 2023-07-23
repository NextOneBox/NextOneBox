const express = require('express');
const router = express.Router();
const User = require('./userSceama');


router.delete('/:id/:uid', async (req, res) => {
    const postId = req.params.id;
    const userId = req.params.uid; 
    
    User.findByIdAndUpdate(
      postId,
      { $pull: { following:  userId} },
      { new: true }
    )
      .then(updatedPost => {
        console.log(updatedPost);
      })
      .catch(error => {
        console.error(error);
      });
   
  });



router.post('/:postId', async (req, res) => {
  const postId = req.params.postId;
  const { user } = req.body;

 
  User.findByIdAndUpdate(
    postId,
    { $push: { following: user } },
    { new: true }
  )
    .then(updatedPost => {
      console.log(updatedPost);
    })
    .catch(error => {
      console.error(error);
    });
  

});

module.exports = router;
