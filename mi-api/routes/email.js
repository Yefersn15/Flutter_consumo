const express = require('express');
const nodemailer = require('nodemailer');
const router = express.Router();

// Configuración del transporte (usando Gmail)
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'yefersonandres225@gmail.com',
    pass: 'dvaf jxxp qphd hiqf' // La nueva contraseña
  }
});

// Endpoint para enviar correo
router.post('/send', async (req, res) => {
  const { to, subject, text } = req.body;

  if (!to || !subject || !text) {
    return res.status(400).json({ message: 'Faltan campos' });
  }

  const mailOptions = {
    from: '"App Flutter" <carlosgomez0717@gmail.com>',
    to,
    subject,
    text,
    html: `<p>${text}</p>`
  };

  try {
    await transporter.sendMail(mailOptions);
    res.json({ message: 'Correo enviado' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;
