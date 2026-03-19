import 'package:flutter/material.dart';

class Slider_Demo extends StatefulWidget {
  const Slider_Demo({Key? key}) : super(key: key);

  @override
  State<Slider_Demo> createState() => _Slider_DemoState();
}

class _Slider_DemoState extends State<Slider_Demo> {
  double _currentValue = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider Example'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(
            value: _currentValue,
            min: 0,
            max: 100,
            divisions: 10,
            label: _currentValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentValue = value;
              });
            },
          ),
          Text('Valor: ${_currentValue.round()}'),
        ],
      ),
    );
  }
}