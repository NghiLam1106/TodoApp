require('dotenv').config();
const express = require('express');
const cors = require('cors');

const app = express();

const authRoutes = require('./routes/auth_routes');


// Middleware
app.use(cors({ origin: true, credentials: true }));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => {
  res.status(200).send('Hello Express + JavaScript');
});

app.use('/api/user/auth', authRoutes);

app.listen(3000, '0.0.0.0', () => {
  console.log('Server running on port 3000');
});
