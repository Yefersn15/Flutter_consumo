import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  
  bool _isLoading = false;
  String _statusMessage = '';

  final String _baseUrl = 'https://flutter-consumo.onrender.com/api'; // Ajusta si es necesario

  Future<void> _sendEmail() async {
    if (_toController.text.isEmpty || _subjectController.text.isEmpty || _bodyController.text.isEmpty) {
      setState(() {
        _statusMessage = 'Por favor complete todos los campos';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _statusMessage = 'Enviando correo...';
    });

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/email/send'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'to': _toController.text.trim(),
          'subject': _subjectController.text,
          'text': _bodyController.text,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _statusMessage = 'Correo enviado con éxito!';
          _isLoading = false;
        });
        _toController.clear();
        _subjectController.clear();
        _bodyController.clear();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Correo enviado exitosamente!')),
          );
        }
      } else {
        final data = json.decode(response.body);
        setState(() {
          _statusMessage = 'Error: ${data['message'] ?? 'Error desconocido'}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error de conexión: $e';
        _isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _toController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enviar Correo Electrónico'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.email, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 20),
            TextField(
              controller: _toController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Destinatario',
                hintText: 'correo@ejemplo.com',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: 'Asunto',
                hintText: 'Asunto del correo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.subject),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bodyController,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Mensaje',
                hintText: 'Escriba su mensaje aquí...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _sendEmail,
              icon: _isLoading 
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send),
              label: Text(_isLoading ? 'Enviando...' : 'Enviar Correo'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            if (_statusMessage.isNotEmpty) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _statusMessage.contains('éxito') 
                    ? Colors.green.shade100 
                    : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _statusMessage,
                  style: TextStyle(
                    color: _statusMessage.contains('éxito') 
                      ? Colors.green.shade800 
                      : Colors.red.shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
