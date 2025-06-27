import 'package:flutter/material.dart';
import 'package:smart_house_app/services/auth_service.dart';
import 'package:smart_house_app/services/meta_service.dart';
import 'package:smart_house_app/widgets/auth_input.dart';
import 'package:smart_house_app/widgets/landing_button.dart';
import 'package:smart_house_app/widgets/layouts/auth_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = AuthService();

  String _email = '';
  String _password = '';
  bool _isLoading = false;

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    _formKey.currentState!.save();

    try {
      await _auth.signInWithEmailAndPassWord(
        email: _email,
        password: _password,
      );
      await MetaService().updateMeta();
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/app');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao fazer login: ${e.toString()}")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      pageTitle: "Login",
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthInputField(
              labelText: 'Email',
              prefixIcon: Icons.alternate_email_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
              value != null && value.contains('@') ? null : 'Email inválido',
              onSaved: (value) => _email = value!.trim(),
            ),
            const SizedBox(height: 16),
            AuthInputField(
              labelText: 'Senha',
              prefixIcon: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              validator: (value) =>
              value != null && value.length >= 6 ? null : 'Mínimo 6 caracteres',
              onSaved: (value) => _password = value!,
            ),
            const SizedBox(height: 24),
            LandingButton(
              text: "Entrar",
              primary: true,
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : null,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
              child: const Text("Ainda não tem conta? Registre-se", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
