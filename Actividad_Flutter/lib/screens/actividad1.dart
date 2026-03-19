import 'package:flutter/material.dart';

class Actividad1 extends StatelessWidget {
  const Actividad1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividad1'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Primera fila: Text1 y Text2
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Text1', style: TextStyle(color: Colors.red)),
                SizedBox(width: 20), // Espacio entre columnas
                Text('Text2', style: TextStyle(color: Colors.green)),
              ],
            ),
            const SizedBox(height: 10), // Espacio entre filas
            // Segunda fila: Text3 y Text4
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Text3', style: TextStyle(color: Colors.blue)),
                SizedBox(width: 20),
                Text('Text4', style: TextStyle(color: Colors.orange)),
              ],
            ),
            const SizedBox(height: 20), // Espacio antes de "BIENVENIDO"
            const Text('BIENVENIDO'),
          ],
        ),
      ),
    );
  }
}