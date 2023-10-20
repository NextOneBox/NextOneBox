// user.js
const mongoose = require('mongoose');

const TaskSchema = new mongoose.Schema({
  ID: { type: String, required: true },
  Name: { type: String ,required: true },
  Favorite: { type: String, required: true },
  Description: { type: String, required: true },
  image: { type: String, required: true },
  Referlink: { type: String, required: true },
  Howtoearn: { type: String, required: true },
  Benifits: { type: String, required: true },
  Price: { type: Number, required: true },
  Catagories: { type: String, required: true },
  
});
module.exports = mongoose.model('Task', TaskSchema);

