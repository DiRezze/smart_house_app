
import 'package:flutter/material.dart';
import 'package:smart_house_app/services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Você está logado"),
            ElevatedButton(
              onPressed: () {
                AuthService().signOut();
              },
              child: const Text('Sair'),
            ),
          ],
        )
      ),
    );
  }
}