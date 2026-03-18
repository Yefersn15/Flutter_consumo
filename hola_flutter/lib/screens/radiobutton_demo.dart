import 'package:flutter/material.dart';

class Radio_Demo extends StatefulWidget {
  const Radio_Demo({Key? key}) : super(key: key);

  @override
  State<Radio_Demo> createState() => _Radio_DemoState();
}

class _Radio_DemoState extends State<Radio_Demo> {
  String _selectedOption = 'A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio Example'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: const Text('Opción A'),
            leading: Radio<String>(
              value: 'A',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Opción B'),
            leading: Radio<String>(
              value: 'B',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
