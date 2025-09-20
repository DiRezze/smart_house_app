import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_app/models/device_model.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/layouts/devices_layout.dart';
import 'package:smart_house_app/widgets/popups/snack_bar.dart';

class DeviceInfoPage extends StatefulWidget {
  final Device device;

  const DeviceInfoPage({
    super.key,
    required this.device,
  });

  @override
  State<DeviceInfoPage> createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  late bool isOn;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    isOn = widget.device.state is bool ? widget.device.state as bool : false;
  }

  void _toggleSwitch(bool value) {
    setState(() {
      isOn = value;
    });
  }

  void _editDevice() {
    // TODO: implementar lógica de edição
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Editar dispositivo")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = widget.device.lastUpdate.toIso8601String();

    return DevicesLayout(
      floatingActionButton: FloatingActionButton(
      onPressed: _editDevice,
      backgroundColor: AppColors.primary,
      child: const Icon(Icons.edit),
    ),
      showBackButton: true,
      title: widget.device.name,
      childWidget: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),

            // Ícone principal
            Icon(
              widget.device.iconData,
              size: 72,
              color: isOn ? Colors.blue : Colors.grey,
            ),

            const SizedBox(height: 20),

            Card(
              color: AppColors.inputBackground,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isOn ? "Ligado" : "Desligado",
                      style: TextStyle(
                        fontSize: 16,
                        color: isOn ? Colors.blue : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Switch(
                      value: isOn,
                      onChanged: _toggleSwitch,
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: AppColors.outline,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            _infoCard(
              icon: Icons.tag_rounded,
              title: "Tópico",
              value: widget.device.topic,
            ),

            const SizedBox(height: 12),

            _infoCard(
              icon: Icons.update,
              title: "Última atualização",
              value: formattedDate,
            ),

            const SizedBox(height: 12),

            Card(
              color: AppColors.inputBackground,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Remover",
                      style: TextStyle(
                        fontSize: 16,
                        color: isOn ? Colors.blue : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                        onPressed: () async {

                          if (_isDeleting) return;

                          setState(() => _isDeleting = true);

                          try {
                            await widget.device.delete();

                            AppSnackBar.showInfo(context, "Dispositivo excluído");

                            Navigator.of(context).pop();

                          } catch (e) {
                            if (!mounted) return;
                            AppSnackBar.showError(context, e.toString());
                          } finally {
                            if (mounted) setState(() => _isDeleting = false);
                          }
                        },
                        icon: Icon(CupertinoIcons.trash_fill, color: AppColors.gray),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      color: AppColors.inputBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.analogPrimary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
