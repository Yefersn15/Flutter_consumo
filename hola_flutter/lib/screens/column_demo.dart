import 'package:flutter/material.dart';

class Column_Demo extends StatelessWidget {
  const Column_Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demostración de widgets'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('We move under cover and we move as one'),
          const Text('Throush the night, we have one shot to live another day'),
          const Text('We cannot let a tray gunshot give us away'),
          const Text('We will fight up close, seize the moment and stay in it'),
          const Text('Its either that or meet the business and of a beyonet'),
          const Text('The code word is ´Ronchambeau,´ dig me'),
          Text('´Ronchambeau',
              style: DefaultTextStyle.of(context)
                  .style
                  .apply(fontSizeFactor: 1.0)),
        ],
      )),
    );
  }
}
