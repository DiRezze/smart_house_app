import 'package:flutter/material.dart';
import 'package:smart_house_app/services/auth_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // centraliza verticalmente
          children: [
            Text(
              'Configurações',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                AuthService().signOut();
              },
              label: Text("Desconectar"),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),

    );
  }
}

