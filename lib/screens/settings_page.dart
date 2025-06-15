import 'package:flutter/material.dart';
import 'package:smart_house_app/services/auth_service.dart';
import 'package:smart_house_app/services/prefs_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Configurações',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                AuthService().signOut();
                PrefsService().remove('displayName');
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
