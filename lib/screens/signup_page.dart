import 'package:flutter/material.dart';
import 'package:smart_house_app/widgets/layouts/auth_layout.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      pageTitle: "Cadastro",
      child: Text("Essa é a tela de cadastro", style: TextStyle(color: Colors.white),),
    );
  }

}

