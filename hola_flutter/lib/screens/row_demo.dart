import 'package:flutter/material.dart';

class Row_Demo extends StatelessWidget {
  const Row_Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Demostración de Row'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
            child: Row(
          children: const <Widget>[
            FlutterLogo(),
            Expanded(
              child: Text(
                  "Flutter's hot roload helps you quickly ad easily experiment, build UIs, add feature, and fix bugs faster. Experience sub-second reload times, without losing state, on emulators, simulators, and hardware for iOS and Android"),
            ),
            Icon(Icons.sentiment_very_satisfied),
          ],
        )));
  }
}
