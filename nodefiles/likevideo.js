const express = require('express');
const router = express.Router();
const VideoPost = require('./videoUploaScea');




router.delete('/:id/:uid', async (req, res) => {
    const postId = req.params.id;
    const userId = req.params.uid; // ID of the comment you want to delete
    
    VideoPost.findByIdAndUpdate(
      postId,
      { $pull: { likes:  userId} },
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

 
  VideoPost.findByIdAndUpdate(
    postId,
    { $push: { likes: user } },
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
