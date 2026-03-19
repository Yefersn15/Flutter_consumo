const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  name: { type: String, required: true },
  surname: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  birthDate: { type: String, required: true }, // Formato YYYY-MM-DD
  sex: { type: String, required: true }
});

module.exports = mongoose.model('User', userSchema);