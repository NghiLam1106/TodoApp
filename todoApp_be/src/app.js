require('dotenv').config();
const express = require('express');

const app = express();
app.use(express.json());

app.get('/', (req, res) => {
  res.status(200).send('Hello Express + JavaScript');
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});
