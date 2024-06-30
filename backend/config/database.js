const mongoose = require('mongoose');

const DB = process.env.MONGODB_URI;

mongoose.connect(DB, {
  useNewUrlParser: true,
  useUnifiedTopology: true
});

const conn = mongoose.connection;

conn.on('error', console.error.bind(console, 'MongoDB connection error:'));
conn.once('open', () => {
  console.log('Connected to MongoDB');
});

module.exports = conn;