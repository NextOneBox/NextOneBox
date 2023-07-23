const express = require('express');
const router = express.Router();
const VideoPost = require('./videoUploaScea');




router.delete('/:id/:cid', async (req, res) => {
    const postId = req.params.id;
    const commentId = req.params.cid; // ID of the comment you want to delete
    
    VideoPost.findByIdAndUpdate(
      postId,
      { $pull: { comments: { _id: commentId } } },
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
  const { user, text } = req.body;



  const newComment = {
    user: user,
    text: text
  };


  VideoPost.findByIdAndUpdate(
    postId,
    { $push: { comments: newComment } },
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
