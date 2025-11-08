import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_house_app/services/prefs_service.dart';

class WeatherService {

  WeatherService () {
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  final Map<String, Map<String, dynamic>> _cache = {};

  final dio = Dio();

  Future<Map<String, dynamic>?> getWeather() async {
    final apiKey = dotenv.env['WEATHER_API'];

    var city = await PrefsService().getString('city');

    if(city == null || city.isEmpty) city = "Garça";

    if (_cache.containsKey(city)) {
      return _cache[city];
    }

    final response = await dio.get(
      baseUrl,
      queryParameters: {
        'q': city,
        'appid': apiKey,
        'units': 'metric',
        'lang': 'pt_br',
      },
    );

    if (response.statusCode == 200) {
      _cache[city] = response.data;
      return response.data;
    } else {
      print('Erro: ${response.statusCode}');
      return null;
    }
  }

  IconData getWeatherIcon(String iconCode) {
    switch (iconCode) {
      case '01d':
      case '01n':
        return Icons.wb_sunny;
      case '02d':
      case '02n':
        return Icons.cloud_queue;
      case '03d':
      case '03n':
        return Icons.cloud;
      case '04d':
      case '04n':
        return Icons.cloud;
      case '09d':
      case '09n':
        return Icons.grain;
      case '10d':
      case '10n':
        return Icons.grain;
      case '11d':
      case '11n':
        return Icons.flash_on;
      case '13d':
      case '13n':
        return Icons.ac_unit;
      case '50d':
      case '50n':
        return Icons.dehaze;
      default:
        return Icons.wb_cloudy;
    }
  }

}