import 'package:flutter/material.dart';
import 'package:smart_house_app/services/auth_service.dart';
import 'package:smart_house_app/services/prefs_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/big_icon_button.dart';

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
            SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                spacing: 8,
                children: [
                  BigIconButton(
                      title: "Usuário",
                      description: "Prenferências e privacidade",
                      onPressed: (){
                        Navigator.of(context).pushNamed("/user-settings");
                      },
                      icon: Icon(Icons.person_rounded, color: Colors.white, size: 42),
                      color: AppColors.analogPrimary,
                  ),
                  BigIconButton(
                    title: "Sobre",
                    description: "Informações do software",
                    onPressed: (){
                      Navigator.of(context).pushNamed("/about");
                    },
                    icon: Icon(Icons.info_rounded, color: Colors.white, size: 42),
                    color: AppColors.primary,
                  ),
                  BigIconButton(
                    title: "Depuração",
                    description: "Funcionalidades experimentais",
                    onPressed: (){
                      Navigator.of(context).pushNamed("/debug");
                    },
                    color: AppColors.errorOutline,
                    icon: Icon(Icons.developer_mode_rounded, color: Colors.white, size: 42),
                  ),
                  BigIconButton(
                    title: "Logout",
                    description: "Encerrar a sessão atual",
                    onPressed: (){
                      AuthService().signOut();
                      PrefsService().remove('displayName');
                    },
                    color: AppColors.outline,
                    icon: Icon(Icons.logout_rounded, color: Colors.white, size: 42),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
