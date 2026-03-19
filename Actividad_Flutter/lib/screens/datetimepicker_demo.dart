import 'package:flutter/material.dart';

class DateTimePicker_Demo extends StatefulWidget {
  const DateTimePicker_Demo({Key? key}) : super(key: key);

  @override
  State<DateTimePicker_Demo> createState() => _DateTimePicker_DemoState();
}

class _DateTimePicker_DemoState extends State<DateTimePicker_Demo> {
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DateTimePicker Example'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _selectedDate == null
                  ? 'No hay fecha seleccionada'
                  : 'Fecha: ${_selectedDate!.toLocal()}'.split(' ')[0],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickDate,
              child: const Text('Seleccionar Fecha'),
            ),
          ],
        ),
      ),
    );
  }
}