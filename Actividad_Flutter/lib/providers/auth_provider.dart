// providers/auth_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthResult {
  final bool success;
  final String? message;
  AuthResult({required this.success, this.message});
}

class AuthProvider extends ChangeNotifier {
  String? _token;
  Map<String, dynamic>? _user;
  bool _isLoading = false;

  String? get token => _token;
  Map<String, dynamic>? get user => _user;
  bool get isAuthenticated => _token != null;
  bool get isLoading => _isLoading;

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
  Future<AuthResult> register({
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
        // Guardamos los datos del usuario devueltos por el servidor
        final data = json.decode(response.body);
        _token = 'local_token_${DateTime.now().millisecondsSinceEpoch}';
        
        // Combinar datos del backend con los del formulario (apellido, sexo y contraseña)
        _user = {
          ...data,
          'surname': surname,
          'sex': sex,
          'password': password, // Solo para validación local
        };
        
        await _saveCredentials();
        return AuthResult(success: true);
      } else if (response.statusCode == 400) {
        // Intenta extraer el mensaje de error del servidor
        final Map<String, dynamic> data = json.decode(response.body);
        String errorMsg = data['message'] ?? 'Error en el registro';
        // Si es error de duplicado, mostrar mensaje más amigable
        if (errorMsg.contains('duplicate key') && errorMsg.contains('email')) {
          errorMsg = 'El correo electrónico ya está registrado';
        }
        return AuthResult(success: false, message: errorMsg);
      } else {
        return AuthResult(success: false, message: 'Error en el registro (código ${response.statusCode})');
      }
    } catch (e) {
      print('Error en register: $e');
      return AuthResult(success: false, message: 'Error de conexión: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Inicio de sesión
  Future<AuthResult> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Intentar login via API
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
            'name': email.split('@')[0],
            'email': email,
          };
          await _saveCredentials();
          return AuthResult(success: true);
        }
      } catch (e) {
        // Si falla la API, intentar validación local
      }
      
      // Validación local usando los datos guardados
      try {
        final prefs = await SharedPreferences.getInstance();
        final userData = prefs.getString('user');
        if (userData != null) {
          final Map<String, dynamic> savedUser = json.decode(userData);
          if (savedUser['email'] == email && savedUser['password'] == password) {
            _token = savedUser['token'] ?? 'local_token_${DateTime.now().millisecondsSinceEpoch}';
            _user = savedUser;
            await _saveCredentials();
            return AuthResult(success: true);
          }
        }
        return AuthResult(success: false, message: 'Credenciales incorrectas');
      } catch (e) {
        return AuthResult(success: false, message: 'Error al iniciar sesión');
      }
    } catch (e) {
      print('Error en login: $e');
      return AuthResult(success: false, message: 'Error al iniciar sesión');
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
  String? get userSurname => _user?['surname'] as String?;
  String? get userSex => _user?['sex'] as String?;
}