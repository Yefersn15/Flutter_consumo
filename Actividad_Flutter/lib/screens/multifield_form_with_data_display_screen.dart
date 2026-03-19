import 'package:flutter/material.dart';

class MultiFieldFormWithDataDisplayScreen extends StatefulWidget {
  const MultiFieldFormWithDataDisplayScreen({super.key});

  @override
  State<MultiFieldFormWithDataDisplayScreen> createState() => _MultiFieldFormWithDataDisplayScreenState();
}

class _MultiFieldFormWithDataDisplayScreenState extends State<MultiFieldFormWithDataDisplayScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _phone = '';
  String _dob = '';
  final TextEditingController _dobController = TextEditingController();
  DateTime? _selectedDob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario múltiple'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Name'),
              const SizedBox(height: 4),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text!';
                  }
                  final reg = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+?');
                  // Allow letters and spaces (basic support for Spanish accents and ñ)
                  final letters = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+?');
                  if (!letters.hasMatch(value)) {
                    return 'Solo letras y espacios';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              if (_name.isNotEmpty) Text('Your name is $_name'),
              const SizedBox(height: 16),

              const Text('Phone'),
              const SizedBox(height: 4),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter phone number',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid phone number';
                  }
                  final digits = RegExp(r'^\d+?');
                  if (!digits.hasMatch(value)) return 'Solo números';
                  return null;
                },
                onSaved: (value) => _phone = value!,
              ),
              if (_phone.isNotEmpty) Text('Your phone is $_phone'),
              const SizedBox(height: 16),

              const Text('Dob'),
              const SizedBox(height: 4),
              TextFormField(
                controller: _dobController,
                readOnly: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Selecciona fecha',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDob ?? now,
                    firstDate: DateTime(1900),
                    lastDate: now,
                  );
                  if (picked != null) {
                    _selectedDob = picked;
                    _dobController.text = '${picked.day}/${picked.month}/${picked.year}';
                    setState(() {});
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid date';
                  }
                  return null;
                },
                onSaved: (value) => _dob = _dobController.text,
              ),
              if (_dob.isNotEmpty) Text('Your date is $_dob'),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    setState(() {});
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

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }
}