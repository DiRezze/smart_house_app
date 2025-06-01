import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Configurações',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}