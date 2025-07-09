import 'package:flutter/material.dart';
import 'package:smart_house_app/constants/app_info.dart';

class AppTitle extends StatelessWidget {
  final bool? showVersion;

  const AppTitle({
    super.key,
    this.showVersion = false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppInfo.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 48,
          ),
        ),
        if (showVersion!)
          Text(
            "Versão ${AppInfo.version}",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
      ],
    );
  }
}