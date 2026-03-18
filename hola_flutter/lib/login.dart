import 'package:flutter/material.dart';
import 'auth.dart';
import 'register.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  bool _isEmailValid(String value) {
    return value.trim().contains('@');
  }

  void _tryLogin() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (!UserRepository.isRegistered()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sin registro'),
          content: const Text('No hay usuarios registrados. ¿Deseas registrarte?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage(title: 'Registrarse')));
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      );
      return;
    }

    if (UserRepository.validate(_email, _password)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Correo o contraseña incorrectos')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Iniciar sesión', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Correo', filled: true, fillColor: Colors.grey.shade200),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Ingrese correo';
                    if (!_isEmailValid(v)) return 'Correo inválido';
                    return null;
                  },
                  onSaved: (v) => _email = v!.trim(),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Contraseña', filled: true, fillColor: Colors.grey.shade200),
                  obscureText: true,
                  validator: (v) => (v == null || v.isEmpty) ? 'Ingrese contraseña' : null,
                  onSaved: (v) => _password = v!,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(onPressed: _tryLogin, child: const Text('Iniciar sesión')),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿No tienes cuenta?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage(title: 'Registrarse')));
                      },
                      child: const Text('Registrarse'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
