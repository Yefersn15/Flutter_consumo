import 'package:flutter/material.dart';

class Imagenes_Demo extends StatelessWidget {
  const Imagenes_Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demostración de imagen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Image(
        image: NetworkImage('https://c.tenor.com/theTensRS5UAAAAC/tenor.gif'),
      ),
    );
  }
}
