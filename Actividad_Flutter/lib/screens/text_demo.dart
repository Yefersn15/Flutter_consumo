import 'package:flutter/material.dart';

class Text_Demo extends StatefulWidget {
  const Text_Demo({Key? key}) : super(key: key);

  @override
  State<Text_Demo> createState() => _Text_DemoState();
}

class _Text_DemoState extends State<Text_Demo> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('simple Code'),
      ),
      body: Center(
        child: Text(
          'You have pressed the button $_counter time.',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold, // Corregido: fontWeight
          ),
        ),
      ), // <-- Se cerró correctamente el Center
      backgroundColor: Colors.blueGrey.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _counter++),
        tooltip: 'increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}