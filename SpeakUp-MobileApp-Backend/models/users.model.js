const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const User = Schema({
    username: {
        type: String,
        required: true,
    },
    rollNo: {
        type: String,
        required: true,
        unique: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    year: {
        type: String,
        required: true,
    },
    dept: {
        type: String,
        required: true,
    },
    password: {
        type: String,
        required: true,
    },
});

module.exports = mongoose.model("User", User);