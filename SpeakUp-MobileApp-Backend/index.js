const express = require('express');
const mongoose = require('mongoose');
const port = process.env.port || 8000;
const app = express();

mongoose.connect(
  'mongodb+srv://Glen_Dsouza_10:speakup@cluster0.agd8b.mongodb.net/ThirdSemProj?retryWrites=true&w=majority',
  {
    useNewUrlParser: true,
    useCreateIndex: true,
    useUnifiedTopology: true,
  }
);

const connection = mongoose.connection;
connection.once('open', () => {
  console.log('MongoDB connected');
});

app.use(express.json());
const userRoute = require('./routes/user');
app.use('/user', userRoute);
const profileRoute = require('./routes/profile');
app.use('/profile', profileRoute);
const complaintRoute = require('./routes/complaint');
app.use('/complaint', complaintRoute);

app.route('/').get((req, res) => res.json('Your first Rest API'));

app.listen(port, () => console.log(`Your server is running on Port ${port}`));
