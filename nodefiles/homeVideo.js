const express = require('express');
const router = express.Router();

const User = require('./userSceama');

const Video =  require('./videoUploaScea');

router.get('/:id', async (req, res) => {
  try {
    const userId = req.params.id;
    const user = await User.findById(userId)
      .populate({
        path: 'following',
        populate: {
          path: 'VideoPost',
          model: 'VideoPost',
          options: { sort: { createdAt: -1 }, limit: 5 }
        }
      })
    //   .select('topic')
    //   .populate({
    //     path: 'topic',
    //     model: 'topic',
    //     options: { sort: { createdAt: -1 }, limit: 5 }
    //   });

    const videos = user.following.reduce((acc, following) => {
      return acc.concat(following.posts);
    }, []);

    // Filter out videos that the user has already watched
    const watchedVideos = user.watched;
    const filteredVideos = videos.filter(video => !watchedVideos.includes(video._id));

    res.json(filteredVideos);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server Error' });
  }
});




  
  module.exports = router;
