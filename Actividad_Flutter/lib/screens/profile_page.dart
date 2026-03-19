// screens/profile_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Función para calcular edad desde birthDate
  String _calculateAge(String? birthDate) {
    if (birthDate == null || birthDate.isEmpty) return 'No especificada';
    
    try {
      // birthDate viene en formato YYYY-MM-DD
      final parts = birthDate.split('-');
      if (parts.length != 3) return 'Fecha inválida';
      
      final birth = DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
      final now = DateTime.now();
      int age = now.year - birth.year;
      
      // Ajustar si no ha cumplido años este año
      if (now.month < birth.month || (now.month == birth.month && now.day < birth.day)) {
        age--;
      }
      
      return '$age años';
    } catch (e) {
      return 'Fecha inválida';
    }
  }

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
                  const SizedBox(height: 8),
                  Text('Edad: ${_calculateAge(user['birthDate'])}',
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
            )
          : const Center(child: Text('No has iniciado sesión')),
    );
  }
}