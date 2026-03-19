import 'package:flutter/material.dart';

class Scaffold_Demo extends StatefulWidget {
  // Cambiado a StatefulWidget
  const Scaffold_Demo({Key? key}) : super(key: key);

  @override
  State<Scaffold_Demo> createState() =>
      _Scaffold_DemoState(); // Estado tipado correctamente
}

class _Scaffold_DemoState extends State<Scaffold_Demo> {
  // Nombre de la clase de estado
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('simple Code'),
      ),
      body: Center(
        child: Text('You have pressed the button $_counter time.'),
      ),
      backgroundColor: Colors.blueGrey.shade200,
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _counter++),
        tooltip: 'increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}