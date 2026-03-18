import 'package:flutter/material.dart';

class SimpleEmailFormValidationScreen extends StatefulWidget {
  const SimpleEmailFormValidationScreen({super.key});

  @override
  State<SimpleEmailFormValidationScreen> createState() => _SimpleEmailFormValidationScreenState();
}

class _SimpleEmailFormValidationScreenState extends State<SimpleEmailFormValidationScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validación email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter your email'),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un email';
                  }
                  // Validación simple: debe contener una arroba
                  if (!value.contains('@')) {
                    return 'Email inválido (debe contener @)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Formulario válido')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
