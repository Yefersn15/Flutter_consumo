import 'package:flutter/material.dart';

class GlobalKeyTextFormFieldScreen extends StatefulWidget {
  const GlobalKeyTextFormFieldScreen({super.key});

  @override
  State<GlobalKeyTextFormFieldScreen> createState() => _GlobalKeyTextFormFieldScreenState();
}

class _GlobalKeyTextFormFieldScreenState extends State<GlobalKeyTextFormFieldScreen> {
  final _formKey = GlobalKey<FormState>();
  String _message = ''; // Mensaje que se mostrará al enviar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagen 1 - Form'),
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
                // Sin validator, siempre es válido
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Al presionar, simplemente mostramos el mensaje
                  setState(() {
                    _message = 'no issues';
                  });
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 8),
              // Mostrar el mensaje debajo del botón
              Text(_message),
            ],
          ),
        ),
      ),
    );
  }
}
