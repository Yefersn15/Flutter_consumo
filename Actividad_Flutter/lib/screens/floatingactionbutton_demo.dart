import 'package:flutter/material.dart';

class Fab_Demo extends StatefulWidget {
  const Fab_Demo({Key? key}) : super(key: key);

  @override
  State<Fab_Demo> createState() => _Fab_DemoState();
}

class _Fab_DemoState extends State<Fab_Demo> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAB Example'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text(
          'Contador: $_count',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _count++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}