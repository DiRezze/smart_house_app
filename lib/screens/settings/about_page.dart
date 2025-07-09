import 'package:flutter/material.dart';
import 'package:smart_house_app/constants/app_info.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/app_title.dart';
import 'package:smart_house_app/widgets/big_icon_button.dart';
import 'package:smart_house_app/widgets/layouts/settings_layout.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SettingsLayout(
        title: "Sobre",
        showBackButton: true,
        childWidget: Column(
          children: [
            AppTitle(showVersion: true),
            SizedBox(height: 16),
            BigIconButton(
              title: "Código-fonte",
              description: "Repositório com o código aberto do projeto",
              icon: Icon(Icons.code_rounded, color: Colors.white, size: 42),
              color: AppColors.navBackground,
              onPressed: () async {
                final url = Uri.parse(AppInfo.srcCode);
                await launchUrl(url);
              },
            ),
          ],
        ),
    );
  }
}