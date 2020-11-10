const express = require('express');
const router = express.Router();
const Complaint = require('../models/complaint.model');
const middleware = require('../middleware');
const { db } = require('../models/complaint.model');
const User = require('../models/users.model');

router.route('/add').post((req, res) => {
  const complaint = Complaint({
    name: req.body.name,
    email: req.body.email,
    dept: req.body.dept,
    year: req.body.year,
    institution: req.body.institution,
    subject: req.body.subject,
    body: req.body.body,
    category: req.body.category,
    status: req.body.status,
  });
  complaint
    .save()
    .then(() => {
      console.log('Complaint sent');
      res.status(200).json('Ok');
    })
    .catch((err) => {
      res.status(403).json({ msg: err });
    });
});

module.exports = router;
