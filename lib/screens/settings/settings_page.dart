import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_app/services/auth_service.dart';
import 'package:smart_house_app/services/prefs_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/auth_input.dart';
import 'package:smart_house_app/widgets/big_icon_button.dart';
import 'package:smart_house_app/widgets/layouts/settings_layout.dart';
import 'package:smart_house_app/widgets/text_divider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsLayout(
      title: "Configuraçõoes",
      childWidget: Column(
        spacing: 8,
        children: [
          AuthInputField(
            labelText: "Pesquisar...",
            prefixIcon: CupertinoIcons.search,
            keyboardType: TextInputType.text,
          ),
          BigIconButton(
            title: "Usuário",
            description: "Prenferências e privacidade",
            onPressed: (){
              Navigator.of(context).pushNamed("/user-settings");
            },
            icon: Icon(Icons.person_rounded, color: Colors.white, size: 32),
            color: AppColors.analogPrimary,
          ),
          BigIconButton(
            title: "Sobre",
            description: "Informações do software",
            onPressed: (){
              Navigator.of(context).pushNamed("/about");
            },
            icon: Icon(Icons.info_rounded, color: Colors.white, size: 32),
            color: AppColors.primary,
          ),
          BigIconButton(
            title: "Logout",
            description: "Encerrar a sessão atual",
            onPressed: (){
              AuthService().signOut(context);
              PrefsService().remove('displayName');
            },
            color: AppColors.outline,
            icon: Icon(Icons.logout_rounded, color: Colors.white, size: 32),
          ),
          TextDivider(text: "Experimental"),
          BigIconButton(
            title: "Depuração",
            description: "Funcionalidades experimentais",
            onPressed: (){
              Navigator.of(context).pushNamed("/debug");
            },
            color: AppColors.errorOutline,
            icon: Icon(Icons.developer_mode_rounded, color: Colors.white, size: 32),
          ),
        ],
      ),
    );
  }
}
