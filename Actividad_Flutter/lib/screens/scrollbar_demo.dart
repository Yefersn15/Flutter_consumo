import 'package:flutter/material.dart';
import 'dart:math';

class Scrollbar_Demo extends StatelessWidget {
  const Scrollbar_Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePage(); // Ahora retorna directamente la pantalla sin otro MaterialApp
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  // Lista de 50 elementos para el ejemplo
  final _myList = List.generate(50, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scrollbar'),
      ),
      body: Scrollbar(
        thickness: 15,
        thumbVisibility: true,
        radius: const Radius.circular(30),
        child: ListView.builder(
          itemCount: _myList.length,
          itemBuilder: (context, index) => Card(
            key: ValueKey(_myList[index]),
            margin: const EdgeInsets.all(5),
            elevation: 15,
            color: Colors.accents[Random().nextInt(Colors.accents.length)],
            child: ListTile(
              title: Text(
                _myList[index],
                style: const TextStyle(fontSize: 25),
              ),
            ),
          ),
        ),
      ),
    );
  }
}