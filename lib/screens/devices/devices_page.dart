import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/auth_input.dart';
import 'package:smart_house_app/widgets/device_home_card.dart';
import 'package:smart_house_app/widgets/filter_section.dart';
import 'package:smart_house_app/widgets/layouts/devices_layout.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicesLayout(
        title: "Meus dispositivos",
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/add-device");
          },
          isExtended: true,
          backgroundColor: AppColors.primary,
          tooltip: 'Adicionar dispositivo',
          child: Icon(Icons.add),
        ),
        childWidget: Column(
          children: [
            AuthInputField(
                labelText: "Pesquisar...",
                prefixIcon: CupertinoIcons.search,
                keyboardType: TextInputType.text
            ),
            SizedBox(height: 8),
            FilterSection(
              filters: ["Tudo", "Iluminação", "Aquecimento", "Segurança"],
              onSelected: (index) {
                // TODO: atualizar lista de dispositivos
              },
            ),
            SizedBox(height: 16),
            Column(
              children: [
                DeviceHomeCard(deviceName: "Luz 1", icon: Icons.lightbulb),
                DeviceHomeCard(deviceName: "Luz 2", icon: Icons.lightbulb),
                DeviceHomeCard(deviceName: "Luz 3", icon: Icons.lightbulb),
                DeviceHomeCard(deviceName: "Sensor gás", icon: Icons.sensors),
              ],
            )
          ],
        )
    );
  }

}
