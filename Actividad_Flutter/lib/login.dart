import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
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

  void _tryLogin() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    final result = await authProvider.login(_email, _password);
    
    if (result.success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.message ?? 'Correo o contraseña incorrectos'))
      );
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
                const Text(
                  'Iniciar sesión', 
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Correo', 
                    filled: true, 
                    fillColor: Colors.grey.shade200
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Ingrese correo';
                    if (!_isEmailValid(v)) return 'Correo inválido';
                    return null;
                  },
                  onSaved: (v) => _email = v!.trim(),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Contraseña', 
                    filled: true, 
                    fillColor: Colors.grey.shade200
                  ),
                  obscureText: true,
                  validator: (v) => (v == null || v.isEmpty) ? 'Ingrese contraseña' : null,
                  onSaved: (v) => _password = v!,
                ),
                const SizedBox(height: 20),
                Consumer<AuthProvider>(
                  builder: (context, auth, child) {
                    return SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: auth.isLoading ? null : _tryLogin,
                        child: auth.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Iniciar sesión')
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('¿No tienes cuenta?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (_) => const RegisterPage(title: 'Registrarse')
                          )
                        );
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