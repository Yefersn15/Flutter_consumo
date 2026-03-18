import 'package:flutter/material.dart';

class ImageRotationText extends StatefulWidget {
  const ImageRotationText({super.key});

  @override
  State<ImageRotationText> createState() => _ImageRotationTextState();
}

class _ImageRotationTextState extends State<ImageRotationText> {
  double _rotationAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rotación de Imagen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Transform.rotate(
          angle: _rotationAngle,
          child: const Image(
            image: NetworkImage('https://c.tenor.com/theTensRS5UAAAAC/tenor.gif'),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'rotate_left',
            onPressed: () => setState(() => _rotationAngle -= 0.1),
            tooltip: 'Girar a la izquierda',
            child: const Icon(Icons.rotate_left),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'rotate_right',
            onPressed: () => setState(() => _rotationAngle += 0.1),
            tooltip: 'Girar a la derecha',
            child: const Icon(Icons.rotate_right),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'reset',
            onPressed: () => setState(() => _rotationAngle = 0.0),
            tooltip: 'Restablecer',
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
