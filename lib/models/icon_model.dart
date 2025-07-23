import 'package:flutter/material.dart';

IconData getIcon(int index) {
  switch (index) {
    case 0:
      return Icons.grid_view_rounded;
    case 1:
      return Icons.lightbulb;
    case 2:
      return Icons.sensors;
    case 3:
      return Icons.bed_rounded;
    default:
      return Icons.grid_view_rounded;
  }
}

String getIconName(int index) {
  switch (index) {
    case 0:
      return "Dispositivo";
    case 1:
      return "Lâmpada";
    case 2:
      return "Sensor";
    case 3:
      return "Quarto";
    default:
      return "Padrão";
  }
}
