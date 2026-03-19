import 'package:flutter/material.dart';

class ElevatedButton_Demo extends StatefulWidget {
  const ElevatedButton_Demo({Key? key}) : super(key: key);


  @override
  State<ElevatedButton_Demo> createState() => _ElevatedButton_DemoState();
}

class _ElevatedButton_DemoState extends State<ElevatedButton_Demo> {

  TextEditingController _controller = TextEditingController();
  bool _isEnabled = false;

  void _checkText(String text) {
    setState(() {
      _isEnabled = text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Code Sample"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Escribe algo",
              ),
              onChanged: _checkText,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: null, // botón deshabilitado
              child: const Text("Disabled"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: _isEnabled
                  ? () {
                      print("Botón presionado");
                    }
                  : null,
              child: const Text("Enabled"),
            ),
          ],
        ),
      ),
    );
  }
}