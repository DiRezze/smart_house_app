import 'package:flutter/material.dart';
import 'package:smart_house_app/widgets/layouts/settings_layout.dart';

class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SettingsLayout(
        title: "Usuário",
        showBackButton: true,
        childWidget: Column(
          spacing: 8,
          children: [

          ],
        )
    );
  }
}