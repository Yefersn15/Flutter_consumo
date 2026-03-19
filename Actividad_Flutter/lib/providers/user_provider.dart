// providers/user_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_entity.dart';

class UserProvider extends ChangeNotifier {
  List<UserEntity> _users = [];
  bool _isLoading = false;

  List<UserEntity> get users => _users;
  bool get isLoading => _isLoading;

  final String _baseUrl = 'https://flutter-consumo.onrender.com/api';

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _users = data.map((e) => UserEntity.fromJson(e)).toList();
      }
    } catch (e) {
      print('Error en fetchUsers: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addUser(String name, String email, String birthDate) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'email': email, 'birthDate': birthDate}),
      );
      if (response.statusCode == 201) {
        final newUser = UserEntity.fromJson(json.decode(response.body));
        _users.add(newUser);
        notifyListeners();
      }
    } catch (e) {
      print('Error en addUser: $e');
    }
  }

  Future<void> updateUser(String id, String name, String email, String birthDate) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/users/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'email': email, 'birthDate': birthDate}),
      );
      if (response.statusCode == 200) {
        final updated = UserEntity.fromJson(json.decode(response.body));
        final index = _users.indexWhere((u) => u.id == id);
        if (index != -1) {
          _users[index] = updated;
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error en updateUser: $e');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/users/$id'));
      if (response.statusCode == 200) {
        _users.removeWhere((u) => u.id == id);
        notifyListeners();
      }
    } catch (e) {
      print('Error en deleteUser: $e');
    }
  }
}