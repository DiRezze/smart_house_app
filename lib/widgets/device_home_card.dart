import 'package:flutter/material.dart';
import 'package:smart_house_app/theme/app_colors.dart';

class DeviceHomeCard extends StatefulWidget {
  final String deviceName;
  final IconData icon;
  final bool initialState;
  final ValueChanged<bool>? onChanged;

  const DeviceHomeCard({
    super.key,
    required this.deviceName,
    required this.icon,
    this.initialState = false,
    this.onChanged,
  });

  @override
  State<DeviceHomeCard> createState() => _DeviceHomeCardState();
}

class _DeviceHomeCardState extends State<DeviceHomeCard> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialState;
  }

  void _toggleSwitch(bool value) {
    setState(() {
      isOn = value;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(value);
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
              widget.deviceName,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.analogPrimary
              ),
            ),
            const SizedBox(height: 8),
            Icon(widget.icon, size: 48, color: isOn ? Colors.blue : Colors.grey),
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