import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_house_app/services/weather_service.dart';

class WeatherCard extends StatefulWidget {
  final String? city;
  final double? temperature;
  final String? description;
  final IconData? icon;
  final String? country;

  const WeatherCard({
    super.key,
    this.city,
    this.temperature,
    this.description,
    this.icon,
    this.country
  });

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  double? _temperature;
  String? _description;
  IconData? _icon;
  String? _city;
  String? _country;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    if (widget.temperature != null &&
        widget.city != null &&
        widget.description != null &&
        widget.icon != null) {
      setState(() {
        _city = widget.city;
        _temperature = widget.temperature;
        _description = widget.description;
        _icon = widget.icon;
        _country = widget.country;
        isLoading = false;
      });
    } else {
      final weatherMap = await WeatherService().getWeather();

      String city = weatherMap?['name'];
      String country = weatherMap?['sys']['country'];
      double temp = weatherMap?['main']['temp']?.toDouble() ?? 0.0;
      String description = weatherMap?['weather'][0]['description'];
      String iconCode = weatherMap?['weather'][0]['icon'];

      IconData icon = WeatherService().getWeatherIcon(iconCode);

      setState(() {
        _city = city;
        _country = country;
        _temperature = temp;
        _description = description;
        _icon = icon;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseDecoration = BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade400, Colors.blue.shade600],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );

    if (isLoading) {
      return Container(
        width: double.infinity,
        height: 160,
        decoration: baseDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.white.withOpacity(0.5),
                highlightColor: Colors.white.withOpacity(0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 60,
                      height: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: 80,
                      height: 36,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.white.withOpacity(0.5),
                highlightColor: Colors.white.withOpacity(0.2),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 160,
      decoration: baseDecoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$_city, $_country" ?? '-',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _description != null
                      ? _description![0].toUpperCase() + _description!.substring(1)
                      : 'Sem info',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _temperature != null
                      ? "${_temperature!.toStringAsFixed(1)}°C"
                      : "--°C",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Icon(
              _icon ?? Icons.help_outline,
              color: Colors.white,
              size: 64,
            ),
          ],
        ),
      ),
    );
  }
}