import 'package:flutter/material.dart';
import 'package:smart_house_app/theme/app_colors.dart';
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

          ],
        )
    );
  }

}
