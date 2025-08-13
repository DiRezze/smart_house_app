import 'package:flutter/material.dart';
import 'package:smart_house_app/models/device_model.dart';
import 'package:smart_house_app/services/mqtt_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/popups/snack_bar.dart';

class DeviceHomeCard extends StatefulWidget {
  final Device device;
  final ValueChanged<bool>? onChanged;
  const DeviceHomeCard({
    super.key,
    required this.device,
    this.onChanged,
  });

  @override
  State<DeviceHomeCard> createState() => _DeviceHomeCardState();
}

class _DeviceHomeCardState extends State<DeviceHomeCard> {
  late bool isOn;
  final mqtt = MqttService();

  @override
  void initState() {
    super.initState();

    isOn = widget.device.state is bool ? widget.device.state as bool : false;
  }

  Future<void> _toggleSwitch(bool value) async {
    try {
      int action = isOn ? 0 : 1;
      mqtt.connect(
        username: '---',
        password: '---',
        url: '---',
      );
      mqtt.publish(widget.device, action);
      setState(() {
        isOn = value;
      });
      if (widget.onChanged != null) {
        widget.onChanged!(value);
      }
    } catch (e) {
      AppSnackBar.showError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.inputBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.device.name,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.analogPrimary
              ),
            ),
            const SizedBox(height: 8),
            Icon(widget.device.iconData, size: 48, color: isOn ? Colors.blue : Colors.grey),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isOn ? "Ligado" : "Desligado",
                  style: TextStyle(
                    color: isOn ? Colors.blue : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Switch(
                  value: isOn,
                  onChanged: _toggleSwitch,
                  activeColor: Colors.blue,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: AppColors.outline,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}