import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_house_app/widgets/layouts/auth_layout.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    if (_senhaController.text != _confirmaSenhaController.text) {
      setState(() {
        _errorMessage = 'As senhas não coincidem';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _senhaController.text.trim(),
      );
      // Usuário criado com sucesso
      // Pode redirecionar para home ou login automático
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'Erro ao criar usuário';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      pageTitle: 'Cadastro',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              validator: (value) => value != null && value.contains('@')
                  ? null
                  : 'E-mail inválido',
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              validator: (value) => value != null && value.length >= 6
                  ? null
                  : 'Senha deve ter ao menos 6 caracteres',
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _confirmaSenhaController,
              decoration:
              const InputDecoration(labelText: 'Confirme a senha'),
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              validator: (value) =>
              value != null && value.length >= 6 ? null : 'Senha inválida',
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _signup,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
