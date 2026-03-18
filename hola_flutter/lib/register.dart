import 'package:flutter/material.dart';
import 'auth.dart';

// Validaciones locales para register
bool _isNameValid(String value) {
  final v = value.trim();
  if (v.isEmpty) return false;
  final reg = RegExp(r'^[A-Za-zÀ-ÖØ-öø-ÿÑñ\s]+$');
  // usar comprobación simple: solo letras y espacios
  return reg.hasMatch(v);
}

bool _isEmailValid(String value) {
  return value.trim().contains('@');
}

bool _isPasswordValid(String value) {
  final hasUpper = value.contains(RegExp(r'[A-Z]'));
  final hasDigit = value.contains(RegExp(r'\d'));
  final hasSymbol = value.contains(RegExp(r'[^A-Za-z0-9]'));
  final longEnough = value.length >= 10 && value.length <= 20;
  return hasUpper && hasDigit && hasSymbol && longEnough;
}

void _unused() {}

enum SinginCharacter { femenino, masculino, otro }

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});
  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  SinginCharacter? _sex = SinginCharacter.femenino;

  String _nombre = '';
  String _apellido = '';
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 40, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                'Registrarse',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('¡Ya puedes registrarte, bienvenido!'),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Nombre',
                              hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                              fillColor: Colors.grey.shade200,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(width: 0, style: BorderStyle.none),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(width: 0, style: BorderStyle.none),
                              ),
                              filled: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese su nombre';
                            }
                            if (!_isNameValid(value)) return 'El nombre solo debe contener letras';
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _nombre = value.toString();
                            });
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Apellidos',
                              hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                              fillColor: Colors.grey.shade200,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(width: 0, style: BorderStyle.none),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(width: 0, style: BorderStyle.none),
                              ),
                              filled: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor digite su apellido';
                            }
                            if (!_isNameValid(value)) return 'El apellido solo debe contener letras';
                            return null;
                          },
                          onSaved: (value) {
                            _apellido = value?.trim() ?? '';
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Radio<SinginCharacter>(
                                  value: SinginCharacter.femenino,
                                  groupValue: _sex,
                                  onChanged: (SinginCharacter? value) {
                                    setState(() {
                                      _sex = value;
                                    });
                                  },
                                ),
                                const Text('Femenino')
                              ],
                            ),
                            Row(
                              children: [
                                Radio<SinginCharacter>(
                                  value: SinginCharacter.masculino,
                                  groupValue: _sex,
                                  onChanged: (SinginCharacter? value) {
                                    setState(() {
                                      _sex = value;
                                    });
                                  },
                                ),
                                const Text('Masculino')
                              ],
                            ),
                            Row(
                              children: [
                                Radio<SinginCharacter>(
                                  value: SinginCharacter.otro,
                                  groupValue: _sex,
                                  onChanged: (SinginCharacter? value) {
                                    setState(() {
                                      _sex = value;
                                    });
                                  },
                                ),
                                const Text('Otro')
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Correo',
                              hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                              fillColor: Colors.grey.shade200,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(width: 0, style: BorderStyle.none),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(width: 0, style: BorderStyle.none),
                              ),
                              filled: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'El correo es necesario';
                            if (!_isEmailValid(value)) return 'Correo debe contener @';
                            return null;
                          },
                          onSaved: (value) => _email = value?.trim() ?? '',
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'Contraseña',
                              hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                              fillColor: Colors.grey.shade200,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(width: 0, style: BorderStyle.none),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(width: 0, style: BorderStyle.none),
                              ),
                              filled: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'La contraseña es necesaria';
                            if (!_isPasswordValid(value)) return 'La contraseña debe tener al menos 8 caracteres, 1 mayúscula, 1 número y 1 símbolo';
                            return null;
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Confirmar contraseña',
                              hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                              fillColor: Colors.grey.shade200,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(width: 0, style: BorderStyle.none),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(width: 0, style: BorderStyle.none),
                              ),
                              filled: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (value != _password) {
                              return 'Las contraseñas no coinciden';
                            }
                            return null;
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  final sexStr = _sex == SinginCharacter.femenino
                                      ? 'femenino'
                                      : _sex == SinginCharacter.masculino
                                          ? 'masculino'
                                          : 'otro';
                                  UserRepository.register(
                                      name_: _nombre,
                                      surname_: _apellido,
                                      email_: _email,
                                      password_: _password,
                                      sex_: sexStr);
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text('Usuario registrado correctamente'),
                                    duration: Duration(milliseconds: 1500),
                                  ));
                                  Navigator.pop(context); // volver al login
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Registrarse')),
                        )),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context); // volver al login
                        },
                        child: const Text('Volver al login'),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
