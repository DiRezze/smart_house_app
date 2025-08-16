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
            BigIconButton(
              title: "Metadados",
              description: "Fetch dos metadados do Realtime DB",
              icon: Icon(Icons.data_object_rounded, color: Colors.white, size: 32),
              color: AppColors.gray,
              onPressed: (){
                MetaService().updateMeta();
              },
            ),
            BigIconButton(
              title: "Shared Prefs",
              description: "Limpeza das preferências de usuário",
              icon: Icon(Icons.restore_from_trash_rounded, color: Colors.white, size: 32),
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