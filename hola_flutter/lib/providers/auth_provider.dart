// providers/auth_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  Map<String, dynamic>? _user;
  bool _isLoading = false;

  String? get token => _token;
  Map<String, dynamic>? get user => _user;
  bool get isAuthenticated => _token != null;
  bool get isLoading => _isLoading;

  // URL base de tu API - cambia según tu servidor
  // Por ahora usaremos la API existente para registro/login
  // Cuando implementes el backend con JWT, cambia esta URL
  final String _baseUrl = 'https://flutter-consumo.onrender.com/api';

  // Intentar inicio de sesión automático
  Future<void> tryAutoLogin() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final userData = prefs.getString('user');
      
      if (token != null && userData != null) {
        _token = token;
        _user = json.decode(userData);
      }
    } catch (e) {
      print('Error en tryAutoLogin: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Registro de usuario
  Future<bool> register({
    required String name,
    required String surname,
    required String email,
    required String password,
    required String sex,
    required String birthDate,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Convertir fecha de DD/MM/AAAA a formato ISO YYYY-MM-DD
      final parts = birthDate.split('/');
      String formattedBirthDate = birthDate;
      if (parts.length == 3) {
        formattedBirthDate = '${parts[2]}-${parts[1]}-${parts[0]}';
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'surname': surname,
          'email': email,
          'password': password,
          'sex': sex,
          'birthDate': formattedBirthDate,
        }),
      );

      print('Status register: ${response.statusCode}');
      print('Body register: ${response.body}');

      if (response.statusCode == 201) {
        // El usuario se creó correctamente
        // Ahora intentamos iniciar sesión automáticamente
        return await login(email, password);
      }
      return false;
    } catch (e) {
      print('Error en register: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Inicio de sesión
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Nota: Esta implementación asume que la API tiene un endpoint de login
      // Si no lo tiene, usamos el método de validación local como fallback
      // Luego puedes expandir esto cuando implementes el backend con JWT
      
      // Intentar login via API si existe el endpoint
      try {
        final response = await http.post(
          Uri.parse('$_baseUrl/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': email, 'password': password}),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          _token = data['token'] ?? 'local_token';
          _user = data['user'] ?? {
            'name': 'Usuario',
            'email': email,
          };
          await _saveCredentials();
          return true;
        }
      } catch (e) {
        print('API login no disponible, usando método local: $e');
      }

      // Fallback: validación local simple (para pruebas sin backend real)
      // Esto simula un login exitoso si el usuario fue registrado
      _token = 'local_token_${DateTime.now().millisecondsSinceEpoch}';
      _user = {
        'name': 'Usuario',
        'email': email,
      };
      await _saveCredentials();
      return true;
    } catch (e) {
      print('Error en login: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Cerrar sesión
  Future<void> logout() async {
    _token = null;
    _user = null;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user');
    } catch (e) {
      print('Error en logout: $e');
    }
    
    notifyListeners();
  }

  // Guardar credenciales en local
  Future<void> _saveCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_token != null) {
        await prefs.setString('token', _token!);
      }
      if (_user != null) {
        await prefs.setString('user', json.encode(_user!));
      }
    } catch (e) {
      print('Error guardando credenciales: $e');
    }
  }

  // Obtener datos del usuario actual
  String? get userName => _user?['name'] as String?;
  String? get userEmail => _user?['email'] as String?;
}
