import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smart_house_app/models/device_model.dart';

class MqttService {
  static final MqttService _instance = MqttService._internal();
  factory MqttService() => _instance;
  MqttService._internal();

  late MqttServerClient client;
  bool _connected = false;

  Future<void> connect({required String username, required String password, required  String url}) async {
    if (_connected) return;

    client = MqttServerClient(url, 'flutter_client');
    client.port = 8883;

    client.secure = true;
    client.securityContext = SecurityContext.defaultContext;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client_${DateTime.now().millisecondsSinceEpoch}')
        .authenticateAs(username, password)
        .startClean()
        .withWillQos(MqttQos.atMostOnce);

    client.connectionMessage = connMessage;

    try {
      client.logging(on: true);
      await client.connect();
      _connected = true;
    } catch (e) {
      client.disconnect();
      _connected = false;
      rethrow;
    }
  }

  void publish(Device device, int value) {
    if (!_connected) {
      throw Exception('MQTT não conectado');
    }
    final builder = MqttClientPayloadBuilder();
    builder.addString(value.toString());
    client.publishMessage(
      device.topic,
      MqttQos.atLeastOnce,
      builder.payload!,
    );
  }

  void disconnect() {
    if (_connected) {
      client.disconnect();
      _connected = false;
    }
  }

}
