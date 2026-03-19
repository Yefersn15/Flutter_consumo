const express = require('express');
const User = require('../models/User');
const router = express.Router();

// Login - autenticar usuario
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    
    if (!email || !password) {
      return res.status(400).json({ message: 'Email y contraseña requeridos' });
    }
    
    // Buscar usuario por email
    const user = await User.findOne({ email });
    
    if (!user) {
      return res.status(401).json({ message: 'Credenciales incorrectas' });
    }
    
    // Nota: En producción, usar bcrypt para comparar contraseñas hasheadas
    // Por ahora, comparación directa (temporal para demo)
    if (user.password !== password) {
      return res.status(401).json({ message: 'Credenciales incorrectas' });
    }
    
    // Devolver usuario sin la contraseña
    const userResponse = user.toObject();
    delete userResponse.password;
    
    res.json({ 
      message: 'Login exitoso',
      user: userResponse,
      token: 'local_token_' + Date.now()
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Crear usuario
router.post('/', async (req, res) => {
  try {
    const user = new User(req.body);
    await user.save();
    res.status(201).json(user);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Obtener todos
router.get('/', async (req, res) => {
  try {
    const users = await User.find();
    res.json(users);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Obtener uno
router.get('/:id', async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) return res.status(404).json({ message: 'No encontrado' });
    res.json(user);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Actualizar
router.put('/:id', async (req, res) => {
  try {
    const user = await User.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!user) return res.status(404).json({ message: 'No encontrado' });
    res.json(user);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Eliminar
router.delete('/:id', async (req, res) => {
  try {
    const user = await User.findByIdAndDelete(req.params.id);
    if (!user) return res.status(404).json({ message: 'No encontrado' });
    res.json({ message: 'Eliminado correctamente' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;