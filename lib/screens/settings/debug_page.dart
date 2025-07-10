import 'package:flutter/material.dart';
import 'package:smart_house_app/services/meta_service.dart';
import 'package:smart_house_app/services/prefs_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/big_icon_button.dart';
import 'package:smart_house_app/widgets/layouts/settings_layout.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SettingsLayout(
        title: "Depuração",
        showBackButton: true,
        childWidget: Column(
          spacing: 8,
          children: [
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: 320,
              ),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 1,
                  color: AppColors.gray.withAlpha(77),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.navBackground.withAlpha(77),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      'Protocolo MQTT',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            BigIconButton(
              title: "Metadados",
              description: "Fetch dos metadados do Realtime DB",
              icon: Icon(Icons.data_object_rounded, color: Colors.white, size: 42),
              color: AppColors.gray,
              onPressed: (){
                MetaService().updateMeta();
              },
            ),
            BigIconButton(
              title: "Shared Prefs",
              description: "Limpeza das preferências de usuário",
              icon: Icon(Icons.restore_from_trash_rounded, color: Colors.white, size: 42),
              color: AppColors.gray,
              onPressed: (){
                PrefsService().clear();
              },
            ),
          ],
        )
    );
  }
}