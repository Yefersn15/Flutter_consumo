// screens/profile_page.dart
import 'package:flutter/material.dart';
import '../auth.dart'; // Tu archivo con UserRepository

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLogged = UserRepository.isRegistered();
    final name = UserRepository.name ?? '';
    final surname = UserRepository.surname ?? '';
    final email = UserRepository.email ?? '';
    final sex = UserRepository.sex ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: isLogged
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre: $name $surname', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Email: $email', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Sexo: $sex', style: const TextStyle(fontSize: 18)),
                ],
              ),
            )
          : const Center(child: Text('No has iniciado sesión')),
    );
  }
}
