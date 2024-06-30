require('dotenv').config();
require('./config/database');

const express = require('express');
const cors = require('cors');
const customerRoutes = require('./routes/customerRouter');

const app = express();

// Middleware to parse JSON
app.use(express.json());

// Use the customer routes
app.use('/customer', customerRoutes);

const PORT = 5000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});