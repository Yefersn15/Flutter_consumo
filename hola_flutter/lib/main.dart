import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart'; // Ajusta la ruta
import 'screens/home_menu.dart';
import 'home_page.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        // Puedes agregar otros providers aquí si los necesitas
      ],
      child: MaterialApp(
        title: 'Mi App en Zapp Run',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
      ),
    );
  }
}
