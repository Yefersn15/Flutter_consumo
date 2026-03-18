import 'package:flutter/material.dart';

class ElevatedButton_Demo extends StatefulWidget {
  const ElevatedButton_Demo({Key? key}) : super(key: key);

  @override
  State<ElevatedButton_Demo> createState() => _ElevatedButton_DemoState();
}

class _ElevatedButton_DemoState extends State<ElevatedButton_Demo> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ElevatedButton Example'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contador: $_counter'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Incrementar'),
            ),
          ],
        ),
      ),
    );
  }
}
