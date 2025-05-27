import 'package:flutter/material.dart';
import 'package:smart_house_app/widgets/layouts/auth_layout.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      pageTitle: "Login",
      child: Text("Essa é a tela de login", style: TextStyle(color: Colors.white),),
    );
  }

}
