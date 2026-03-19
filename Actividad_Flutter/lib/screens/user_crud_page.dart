// screens/user_crud_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart'; // Debe apuntar al archivo correcto
import '../models/user_entity.dart';

class UserCrudPage extends StatefulWidget {
  const UserCrudPage({super.key});

  @override
  State<UserCrudPage> createState() => _UserCrudPageState();
}

class _UserCrudPageState extends State<UserCrudPage> {
  @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<UserProvider>().fetchUsers();
  });
}

  void _showUserDialog({UserEntity? user}) {
    final isEditing = user != null;
    final nameCtrl = TextEditingController(text: isEditing ? user.name : '');
    final emailCtrl = TextEditingController(text: isEditing ? user.email : '');
    final birthDateCtrl = TextEditingController(
        text: isEditing ? _formatDateForDisplay(user.birthDate) : '');

    DateTime? selectedDate = isEditing ? DateTime.tryParse(user.birthDate) : null;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(isEditing ? 'Editar Usuario' : 'Nuevo Usuario'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: birthDateCtrl,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Fecha de nacimiento',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: dialogContext,
                    initialDate: selectedDate ?? now,
                    firstDate: DateTime(1900),
                    lastDate: now,
                  );
                  if (picked != null) {
                    selectedDate = picked;
                    birthDateCtrl.text = DateFormat('dd/MM/yyyy').format(picked);
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameCtrl.text.isEmpty ||
                  emailCtrl.text.isEmpty ||
                  selectedDate == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Completa todos los campos')),
                );
                return;
              }
              final provider = context.read<UserProvider>();
              final birthDateIso = DateFormat('yyyy-MM-dd').format(selectedDate!);
              if (isEditing) {
                await provider.updateUser(
                  user.id!,
                  nameCtrl.text,
                  emailCtrl.text,
                  birthDateIso,
                );
              } else {
                await provider.addUser(
                  nameCtrl.text,
                  emailCtrl.text,
                  birthDateIso,
                );
              }
              if (context.mounted) Navigator.pop(dialogContext);
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  String _formatDateForDisplay(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {
      return '';
    }
  }

  int _calculateAge(String birthDate) {
    try {
      final birth = DateTime.parse(birthDate);
      final today = DateTime.now();
      int age = today.year - birth.year;
      if (today.month < birth.month || (today.month == birth.month && today.day < birth.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return 0; // Si hay error en el formato, devolvemos 0
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('CRUD Usuarios')),
      body: userProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: userProvider.users.length,
              itemBuilder: (context, i) {
                final user = userProvider.users[i];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text('${user.email} - Edad: ${_calculateAge(user.birthDate)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showUserDialog(user: user),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => userProvider.deleteUser(user.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUserDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}