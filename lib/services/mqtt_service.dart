import 'dart:convert';
import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smart_house_app/models/broker_model.dart';
import 'package:smart_house_app/models/device_model.dart';
import 'package:smart_house_app/services/prefs_service.dart';

class MqttService {
  static final MqttService _instance = MqttService._internal();
  factory MqttService() => _instance;
  MqttService._internal();

  late MqttServerClient client;
  bool _connected = false;

  Future<void> connect() async {

    final brokerString = await PrefsService().getString("broker");
    if (brokerString == null || brokerString.isEmpty) {
      throw Exception("Nenhuma configuração de broker encontrada");
    }

    final decoded = jsonDecode(brokerString);
    final broker = Broker.fromJson(decoded);

    if (_connected) return;

    client = MqttServerClient(broker.url, 'flutter_client');
    client.port = 8883;

    client.secure = true;
    client.securityContext = SecurityContext.defaultContext;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client_${DateTime.now().millisecondsSinceEpoch}')
        .authenticateAs(broker.user, broker.pass)
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
