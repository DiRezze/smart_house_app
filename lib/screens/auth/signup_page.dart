import 'package:flutter/material.dart';
import 'package:smart_house_app/widgets/auth_input.dart';
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
        if (!mounted) return;
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
            AuthInputField(
              labelText: "Email",
              prefixIcon: Icons.alternate_email_rounded,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              controller: _emailController,
              validator: (value) => value != null && value.contains('@') ? null : 'Email inválido',
            ),
            const SizedBox(height: 16),
            AuthInputField(
              labelText: "Senha",
              prefixIcon: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              controller: _passwordController,
              validator: (value) => value != null && value.length >= 6 ? null : 'Mínimo 6 caracteres',
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
