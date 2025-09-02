import 'package:flutter/material.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/big_icon_button.dart';
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
            BigIconButton(
                title: "App em desenvolvimento",
                description: "Os dados de usuário atuais estão sujeitos a exclusão na transição entre versões MINOR e, principalmente, MAJOR.",
                icon: Icon(Icons.info_rounded, color: Colors.white,),
                color: AppColors.primary,
            )
          ],
        )
    );
  }
}