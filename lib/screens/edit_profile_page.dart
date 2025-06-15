import 'package:flutter/material.dart';
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
  final _birthdateController = TextEditingController();
  DateTime? _selectedBirthdate;

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _birthdateController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: implementar salvamento no Firebase Realtime DB
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Row(
              spacing: 8,
              children: [
                Icon(Icons.check, color: AppColors.primary, size: 24,),
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
      Navigator.pop(context);
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedBirthdate ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedBirthdate = pickedDate;
        _birthdateController.text =
        "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
      });
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
                        padding: const EdgeInsets.only(top: 32), // Ajuste esse valor se quiser mais/menos espaço do topo
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
                        child: const Text(
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