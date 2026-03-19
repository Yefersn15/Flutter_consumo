import 'package:flutter/material.dart';

class Checkbox_Demo extends StatefulWidget {
  const Checkbox_Demo({Key? key}) : super(key: key);

  @override
  State<Checkbox_Demo> createState() => _Checkbox_DemoState();
}

class _Checkbox_DemoState extends State<Checkbox_Demo> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkbox Example'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value!;
            });
          },
        ),
      ),
    );
  }
}