import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:smart_house_app/models/device_model.dart';
import 'package:smart_house_app/services/auth_service.dart';
import 'package:smart_house_app/services/prefs_service.dart';

class DeviceService {

  Future<List<Device>> loadCachedDevices() async {
    final json = await PrefsService().getString("devices");
    if (json == null || json.isEmpty) return [];
    final list = jsonDecode(json) as List;
    return list.map((e) => Device.fromMap(e)).toList();
  }

  Future<void> persistCache() async {
    String devicesJson = jsonEncode(DeviceCache().devices.map((d) => d.toMap()).toList());
    await PrefsService().setString("devices", devicesJson);
  }
  
  Future<List<Device>> fetchDevices() async {

    final uid = AuthService().currentUser?.uid;

    if (uid == null) throw Exception("Usuário não logado");

    final ref = FirebaseDatabase.instance.ref("users/$uid/devices");

    final snapshot = await ref.get();

    if (!snapshot.exists) return [];

    List<Device> devices = [];

    for (var child in snapshot.children) {
      final data = child.value as Map<dynamic, dynamic>;
      final map = Map<String, dynamic>.from(data);

      if (child.key == null || child.key!.isEmpty) continue;

      map['id'] = child.key;

      devices.add(Device.fromMap(map));
    }
    return devices;
  }

  Future<void> updateDevices() async {
    final devices = await fetchDevices();

    DeviceCache().updateDevices(devices);

    String devicesJson = jsonEncode(devices.map((d) => d.toMap()).toList());

    await PrefsService().setString("devices", devicesJson);
  }

  Future<void> flushDevices() async {
    await PrefsService().setString("devices", "[]");
  }

}

class DeviceCache {
  static final DeviceCache _instance = DeviceCache._internal();

  factory DeviceCache() => _instance;
  DeviceCache._internal();

  List<Device> devices = [];

  void updateDevices(List<Device> newDevices) {
    devices = newDevices;
  }

  Device? getDeviceById(String id) {
    return devices.firstWhere((d) => d.id == id);
  }

}