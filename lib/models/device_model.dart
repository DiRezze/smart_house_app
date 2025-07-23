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
      id: map['id'] as String,
      name: map['name'] as String,
      icon: map['icon'] as int,
      topic: map['topic'] as String,
      lastUpdate: DateTime.parse(map['lastUpdate'] as String),
      state: map['state'] as int,
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
