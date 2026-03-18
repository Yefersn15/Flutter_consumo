import 'package:flutter/material.dart';
import 'screens/home_menu.dart';
import 'screens/profile_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('¡BIENVENIDOS a Mi Aplicación en Zapp Run!'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Menú Principal',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text('Ver ejemplos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeMenu()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Acerca de'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ejemplos en Flutter',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            Image.network(
              'https://media.tenor.com/bngmAhHG-jUAAAAi/caps-lock-texting.gif',
              height: 300,
            ),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeMenu()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  child: Text('Hola', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'En esta aplicación encontrarás ejemplos prácticos de los widgets más usados en Flutter:\n'
                '• contadores\n'
                '• listas de tareas\n'
                '• columnas\n'
                '• filas\n'
                '• contenedores\n'
                '• imágenes\n'
                '• navegación entre pantallas.\n'
                'Todo explicado de forma sencilla para que entiendas la estructura básica de una app Flutter.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
