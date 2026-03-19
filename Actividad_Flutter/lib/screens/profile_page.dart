// screens/profile_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    final isLogged = authProvider.isAuthenticated;

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: isLogged && user != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre: ${user['name'] ?? ''} ${user['surname'] ?? ''}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Email: ${user['email'] ?? ''}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Sexo: ${user['sex'] ?? ''}',
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
            )
          : const Center(child: Text('No has iniciado sesión')),
    );
  }
}