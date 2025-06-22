import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_app/services/meta_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/app_input.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isLoading = false;

  final user = FirebaseAuth.instance.currentUser;
  get uid => user?.uid;

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      try {
        final db = FirebaseDatabase.instance;
        final ref = db.ref("users/$uid/meta");

        final data = {
          "displayName": _nameController.text.trim(),
          "lastName": _lastNameController.text.trim(),
          "phone": _phoneController.text.trim(),
          "updatedAt": DateTime.now().toIso8601String(),
        };

        await ref.set(data);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check, color: AppColors.primary, size: 24,),
                const SizedBox(width: 8),
                const Text('Perfil atualizado!'),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            ),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
        await MetaService().updateMeta();

        setState(() => _isLoading = false );

        if (!mounted) return;

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.red, size: 24,),
                const SizedBox(width: 8),
                const Text("Erro ao salvar"),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            ),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: TextButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.chevron_left, color: Colors.white),
                          label: const Text(
                            "Voltar",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Editando perfil',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    AppInput(
                      labelText: 'Nome',
                      prefixIcon: Icons.person,
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Informe seu nome';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppInput(
                      labelText: 'Sobrenome',
                      prefixIcon: Icons.person_add_alt_1_rounded,
                      controller: _lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Informe seu sobrenome';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppInput(
                      labelText: 'Telefone',
                      prefixIcon: Icons.phone,
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Vazio';
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        onPressed: _saveProfile,
                        child: _isLoading ?
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        )
                        :
                        const Text(
                          'Salvar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}