import 'package:flutter/material.dart';

class Container_Demo extends StatelessWidget {
  const Container_Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Demostración de Container'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Container(
              constraints: BoxConstraints.expand(
                height: Theme.of(context).textTheme.headlineMedium!.fontSize! *
                        1.1 +
                    200.0,
              ),
              padding: const EdgeInsets.all(8.0),
              color: Colors.blue[800],
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(0.1),
              child: Text('¡Hello, World!',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Colors.white))),
        ));
  }
}