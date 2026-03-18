import 'package:flutter/material.dart';

class TextField_Demo extends StatefulWidget {
  const TextField_Demo({Key? key}) : super(key: key);

  @override
  State<TextField_Demo> createState() => _TextField_DemoState();
}

class _TextField_DemoState extends State<TextField_Demo> {
  final TextEditingController _controller = TextEditingController();
  String _text = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextField Example'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Escribe algo',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _text = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Text('Texto: $_text'),
          ],
        ),
      ),
    );
  }
}
