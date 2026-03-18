const express = require('express');
const mongoose = require('mongoose');
require('dotenv').config();
const userRoutes = require('./routes/users');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());
app.use('/api/users', userRoutes);

// Ruta de prueba
app.get('/', (req, res) => res.send('API funcionando'));

// Conexión a MongoDB
mongoose.connect(process.env.MONGODB_URI)
  .then(() => console.log('Conectado a MongoDB'))
  .catch(err => console.error(err));

app.listen(PORT, () => console.log(`Servidor en puerto ${PORT}`));