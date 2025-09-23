import 'package:smart_house_app/models/device_model.dart';

class Sensor extends Device {

  bool? enable;

  Sensor({
    this.enable,
    required super.id,
    required super.name,
    required super.icon,
    required super.topic,
    required super.state,
    required super.lastUpdate,
  });

}