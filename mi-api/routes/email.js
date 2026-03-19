const express = require('express');
const nodemailer = require('nodemailer');
const router = express.Router();

// Configuración del transporte (usando Gmail)
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'yefersonandres225@gmail.com',
    pass: 'dvafjxxpqphdhiqf' // Contraseña de aplicación sin espacios
  }
});

// Endpoint para enviar correo
router.post('/send', async (req, res) => {
  const { to, subject, text } = req.body;

  if (!to || !subject || !text) {
    return res.status(400).json({ message: 'Faltan campos' });
  }

  const mailOptions = {
    from: '"App Flutter" <yefersonandres225@gmail.com>', // Debe coincidir con auth.user
    to,
    subject,
    text,
    html: `<p>${text}</p>`
  };

  try {
    const info = await transporter.sendMail(mailOptions);
    console.log('Email enviado: %s', info.messageId);
    res.json({ message: 'Correo enviado correctamente' });
  } catch (error) {
    console.error('Error detallado:', error);
    res.status(500).json({ message: 'Error al enviar correo. Verifica las credenciales.' });
  }
});

module.exports = router;
