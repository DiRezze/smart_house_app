import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/auth_input.dart';
import 'package:smart_house_app/widgets/layouts/devices_layout.dart';
import 'package:smart_house_app/widgets/profile/profile_button.dart';
import 'package:smart_house_app/widgets/text_divider.dart';

class BrokerSettingsPage extends StatelessWidget {
  const BrokerSettingsPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return DevicesLayout(
      title: "Minha central",
      showBackButton: true,
      childWidget: Column(
        spacing: 16,
        children: [
          ProfileButton(
            icon: Icon(Icons.qr_code_2_rounded, color: Colors.white),
            extend: true,
            label: "Configurar com QR Code",
            tint: AppColors.primary,
          ),
          TextDivider(text: "ou"),
          Text(
            "Configuração manual",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
          ),
          Column(
            spacing: 8,
            children: [
              AuthInputField(
                  labelText: "URL",
                  prefixIcon: CupertinoIcons.link,
                  obscureText: false,
                  keyboardType: TextInputType.url
              ),
              AuthInputField(
                  labelText: "Usuário",
                  prefixIcon: CupertinoIcons.person_crop_circle_badge_checkmark,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress
              ),
              AuthInputField(
                  labelText: "Senha",
                  prefixIcon: CupertinoIcons.creditcard_fill,
                  obscureText: true,
                  keyboardType: TextInputType.text
              ),
              ProfileButton(
                icon: Icon(Icons.check, color: Colors.white),
                extend: true,
                label: "Salvar alterações",
                tint: AppColors.primary,
              ),
            ],
          )
        ],
      ),
    );

  }

}
