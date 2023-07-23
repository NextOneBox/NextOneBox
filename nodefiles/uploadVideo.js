const express = require('express');
const router = express.Router();
const mongoose = require("mongoose");
const dotenv = require("dotenv");
dotenv.config()
const multer = require('multer');
const storage = multer.memoryStorage()
const upload = multer({ storage: storage })
const VideoPost = require('./videoUploaScea');


const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");
const s3Client = new S3Client({
  region: "ap-south-1",
  credentials: {
    accessKeyId: "AKIAS6YXFLWYR3DTIP37",
    secretAccessKey: "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",
  },
});

const { models } = require('mongoose');

router.post('/', upload.single('file'), async function (req, res) {
    console.log(req.file);
    try {
      const uploadParams = {
        Bucket: "nextonebox",
        Key: req.file.originalname,
        Body:  req.file.buffer,
        ContentType: req.file.mimetype,
      };
  
      await s3Client.send(new PutObjectCommand(uploadParams));
     
      const newVideoPost = new VideoPost({
        user: '64a527372deedc15806d2900',
        title : req.body.title,
        topic: req.body.topic,
        videoFile: req.file.originalname,
        likes: [],
        comments: [],
        shares: 0,
        views: 0,
      });
      const savedVideoPost = await newVideoPost.save();
      res.json(savedVideoPost);
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: "Server Error" });
    }
  });



const { DeleteObjectCommand } = require('@aws-sdk/client-s3');

// DELETE video post by ID
router.delete('/:id', async (req, res) => {
  const postId = req.params.id;

  try {
    // Find the video post by ID
    const videoPost = await VideoPost.findById(postId);

    if (!videoPost) {
      return res.status(404).json({ message: 'Video post not found' });
    }

    // Delete the file from S3
    const deleteParams = {
      Bucket: 'nextonebox',
      Key: videoPost.videoFile,
    };
    await s3Client.send(new DeleteObjectCommand(deleteParams));

    // Delete the video post from the database
    await VideoPost.deleteOne({ _id: postId });

    res.json({ message: 'Video post deleted successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server Error' });
  }
});

  
  module.exports = router;
