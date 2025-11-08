import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_house_app/services/meta_service.dart';
import 'package:smart_house_app/services/prefs_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/big_icon_button.dart';
import 'package:smart_house_app/widgets/layouts/settings_layout.dart';
import 'package:smart_house_app/widgets/popups/snack_bar.dart';

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
            BigIconButton(
              title: "Mostrar Token",
              description: "Exibe e copia o token do dispositivo",
              icon: const Icon(Icons.key, color: Colors.white, size: 32),
              color: AppColors.gray,
              onPressed: () async {
                String? token = await FirebaseMessaging.instance.getToken();

                if (token != null) {
                  await Clipboard.setData(ClipboardData(text: token));

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Token copiado para a área de transferência! ✅'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Erro ao copiar"),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
            )
          ],
        )
    );
  }
}