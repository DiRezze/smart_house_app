import 'package:flutter/material.dart';
import 'package:smart_house_app/widgets/layouts/devices_layout.dart';

class AddDevicePage extends StatelessWidget {
  const AddDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicesLayout(
        title: "Novo dispositivo",
        childWidget: Column(
          children: [
            Text("Cadastro"),
          ],
        )
    );
  }

}
