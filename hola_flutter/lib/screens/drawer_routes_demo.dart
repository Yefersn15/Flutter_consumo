import 'package:flutter/material.dart';

/// Demostración de un Drawer con navegación a una segunda pantalla.
class DrawerRoutesDemo extends StatelessWidget {
  const DrawerRoutesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const DrawerHomePage();
  }
}

/// Pantalla principal con drawer.
class DrawerHomePage extends StatefulWidget {
  const DrawerHomePage({super.key});

  @override
  State<DrawerHomePage> createState() => _DrawerHomePageState();
}

class _DrawerHomePageState extends State<DrawerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de Drawer'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Regresa al menú principal
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey),
              child: Text(
                ' Menú Lateral',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.message_sharp),
              title: const Text('Mensaje'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SecondRoute(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuraciones'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.change_history),
              title: const Text('Historia'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: const Center(child: Text('Pantalla principal con drawer')),
    );
  }
}

/// Segunda pantalla a la que se navega desde el drawer.
class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Regresar'),
        ),
      ),
    );
  }
}
