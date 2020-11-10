const express = require('express');
const User = require('../models/users.model');
const config = require('../config');
const jwt = require('jsonwebtoken');
const middleware = require('../middleware');

const router = express.Router();

router.route('/:email').get(middleware.checkToken, (req, res) => {
  User.findOne({ email: req.params.email }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      username: result['username'],
      email: req.params.email,
    });
  });
});

router.route('/checkemail/:email').get((req, res) => {
  User.findOne({ email: req.params.email }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    if (result !== null) {
      return res.json({
        Status: true,
      });
    } else
      return res.json({
        Status: false,
      });
  });
});

router.route('/login').post((req, res) => {
  User.findOne({ email: req.body.email }, (err, result) => {
    if (err) {
      return res.status(500).json({ msg: err });
    } else if (result == null) {
      return res.status(403).json('Email does not exist');
    } else if (result.password == req.body.password) {
      let token = jwt.sign({ email: req.body.email }, config.key, {
        expiresIn: '24h',
      });
      res.json({
        token: token,
        msg: 'success',
      });
    } else {
      res.status(403).json('Password is incorrect');
    }
  });
});

router.route('/register').post((req, res) => {
  console.log('Inside the register');
  const user = new User({
    username: req.body.username,
    rollNo: req.body.rollNo,
    email: req.body.email,
    year: req.body.year,
    dept: req.body.dept,
    password: req.body.password,
  });
  user
    .save()
    .then(() => {
      console.log('User registered');
      res.status(200).json('Ok');
    })
    .catch((err) => {
      res.status(403).json({ msg: err });
    });
});

router.route('/update/:email').patch(middleware.checkToken, (req, res) => {
  User.findOneAndUpdate(
    { email: req.params.email },
    { $set: { password: req.body.password } },
    (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      const msg = {
        msg: 'password successfully updated',
        email: req.params.email,
      };
      return res.json(msg);
    }
  );
});

router.route('/delete/:email').delete((req, res) => {
  User.findOneAndDelete({ email: req.params.email }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    const msg = {
      msg: 'Email deleted',
      email: req.params.email,
    };
    return res.json(msg);
  });
});

router.route('/getData').get(middleware.checkToken, (req, res) => {
  User.findOne({ email: req.decoded.email }, (err, result) => {
    if (err) return res.json({ err: err });
    if (result == null) return res.json({ data: [] });
    else return res.json({ data: result });
  });
});

module.exports = router;
