import 'package:flutter/material.dart';
import 'package:smart_house_app/models/icon_model.dart';

class Device {

  Device({
    required this.id,
    required this.name,
    required this.icon,
    required this.topic,
    required this.state,
    required this.lastUpdate,
  });

  /// Immutable identification code in RealtimeDB
  final String id;
  /// Device name displayed in the UI
  String name;
  /// Associated icon
  int icon;
  /// Associated MQTT topic
  String topic;
  /// Last state update timestamp
  DateTime lastUpdate;
  /// Current device state
  int state;

  IconData get iconData => getIcon(icon);
  String get iconLabel => getIconName(icon);

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      icon: map['icon'] is int ? map['icon'] as int : int.tryParse(map['icon']?.toString() ?? '0') ?? 0,
      topic: map['topic']?.toString() ?? '',
      lastUpdate: map['lastUpdate'] != null
          ? DateTime.tryParse(map['lastUpdate'].toString()) ?? DateTime.now()
          : DateTime.now(),
      state: map['state'] is int ? map['state'] as int : int.tryParse(map['state']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'topic': topic,
      'state': state,
      'lastUpdate': lastUpdate.toIso8601String(),
    };
  }

}
