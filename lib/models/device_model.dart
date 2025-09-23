import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_app/models/icon_model.dart';
import 'package:smart_house_app/services/auth_service.dart';
import 'package:smart_house_app/services/device_service.dart';
import 'package:smart_house_app/services/prefs_service.dart';

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

  Future<void> create() async {
    final uid = AuthService().currentUser?.uid;

    if(uid == null) throw Exception("Sessão Expirada");

    final db = FirebaseDatabase.instance;

    final ref = db.ref("users/$uid/devices").push();

    final data = {
      'name': name,
      'icon': icon,
      'topic': topic,
      'state': state,
      'lastUpdate': lastUpdate.toIso8601String(),
    };

    await ref.set(data);

    DeviceService().updateDevices();

  }

  /// atualiza o registro do dispositivo no Realtime DB
  Future<void> update() async {
    final uid = AuthService().currentUser?.uid;

    if (uid == null) throw Exception("Sessão expirada");

    final db = FirebaseDatabase.instance;
    final deviceId = id;

    final ref = db.ref("users/$uid/devices/$deviceId");

    final data = {
      'name': name,
      'icon': icon,
      'topic': topic,
      'state': state,
      'lastUpdate': lastUpdate.toIso8601String(),
    };

    await ref.update(data);

    DeviceService().updateDevices();
  }

  /// remove o dispositivo do RealTime Database
  Future<void> delete() async {

    final uid = AuthService().currentUser?.uid;

    if(uid == null) throw Exception("Sessão expirada");

    final db = FirebaseDatabase.instance;

    final deviceId = id;

    if (deviceId.isEmpty) return;

    final ref = db.ref("users/$uid/devices/$deviceId");

    await ref.remove();

    final cache = DeviceCache();
    cache.devices.removeWhere((d) => d.id == deviceId);

    String devicesJson = jsonEncode(cache.devices.map((d) => d.toMap()).toList());
    await PrefsService().setString("devices", devicesJson);

  }

}
