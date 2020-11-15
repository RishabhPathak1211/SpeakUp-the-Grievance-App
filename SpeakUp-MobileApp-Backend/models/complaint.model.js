const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const Complaint = Schema({
  name: String,
  email: String,
  dept: String,
  year: String,
  institution: {
    type: String,
    default: 'Bennett University',
  },
  subject: String,
  body: String,
  category: String,
  status: Boolean,
});

module.exports = mongoose.model('Complaint', Complaint);
