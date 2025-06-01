import 'package:flutter/material.dart';
import 'package:smart_house_app/widgets/landing_button.dart';
import 'package:smart_house_app/widgets/layouts/auth_layout.dart';
import 'package:smart_house_app/services/auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = AuthService();

  bool _isLoading = false;

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (mounted) {
          Navigator.pushReplacementNamed(context, '/app');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar: ${e.toString()}')),
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      pageTitle: "Cadastro",
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white70),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Digite um e-mail';
                if (!value.contains('@')) return 'E-mail inválido';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: Colors.white70),
              ),
              validator: (value) {
                if (value == null || value.length < 6) return 'Mínimo de 6 caracteres';
                return null;
              },
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const CircularProgressIndicator()
                : LandingButton(text: "Cadastrar",
                primary: true,
                onPressed: _submit
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Já tem uma conta? Entre agora mesmo", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
