const express = require("express");
const router = express.Router();
const Profile = require("../models/profile.model");
const middleware = require("../middleware");

router.route("/add").post(middleware.checkToken, (req, res) => {
    const profile = Profile({
        email: req.decoded.email,
        username:req.decoded.username,
        profession: req.body.profession,
        DOB: req.body.DOB,
        titleline: req.body.titleline,
        about: req.body.about,
    });
    profile.save()
    .then( () => {
        return res.json({msg :"Profile stored successfully"});
    })
    .catch((err) => {
        return res.status(400).json({err:err});
    });
});

router.route("/getData").get(middleware.checkToken, (req, res) => {
    Profile.findOne({ email: req.decoded.email }, (err, result) => {
      if (err) return res.json({ err: err });
      if (result == null) return res.json({ data: [] });
      else return res.json({ data: result });
    });
});

module.exports = router;