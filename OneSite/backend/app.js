const express = require('express');
const app = express();
const port = 3000;
const mongoose = require("mongoose");
const dotenv = require("dotenv");
dotenv.config()
app.use(express.json());
// app.use(express.json({ limit: '10mb' }));
mongoose.connect("mongodb://0.0.0.0:27017/onesite",{ useNewUrlParser:true,useUnifiedTopology:true}).then(()=>console.log("connection successfull")).catch((err) => console.log(err + 'this return error'));
const multer = require('multer');
app.use(express.urlencoded({  extended: false }));
const storage = multer.memoryStorage()
const upload = multer({ storage: storage })



const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");
const s3Client = new S3Client({
  region: "ap-south-1",
  credentials: {
    accessKeyId: "AKIAS6YXFLWYR3DTIP37",
    secretAccessKey: "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",
  },
});



const uploadVideo = require("../nodefiles/uploadVideo")
app.use("/uploadVideo",uploadVideo);

const register = require("../nodefiles/register")
app.use("/register",register);

const comment = require("../nodefiles/comment")
app.use("/comments",comment);

const dashboard = require("../nodefiles/dashboard")
app.use("/dashboard",dashboard);

const videos = require("../nodefiles/homeVideo")
app.use("/videos",videos);

const profile = require("../nodefiles/profile")
app.use("/profile",profile);

const getFallow = require("../nodefiles/getFallow")
app.use("/getFallow",getFallow);

app.listen(port);
