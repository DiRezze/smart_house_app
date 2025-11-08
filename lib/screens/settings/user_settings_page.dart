import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_house_app/services/weather_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/big_icon_button.dart';
import 'package:smart_house_app/widgets/layouts/settings_layout.dart';
import 'package:smart_house_app/widgets/settings_switch.dart';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({super.key});

  @override
  State<UserSettingsPage> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  final service = WeatherService.shared;
  bool _isWeatherPref = true;
  bool _loadingWeather = true;

  @override
  void initState() {
    super.initState();
    _loadWeatherPref();
  }

  Future<void> _loadWeatherPref() async {

    await service.loadPreference();
    setState(() {
      _isWeatherPref = service.isPreferred;
      _loadingWeather = false;
    });
  }

  Future<void> _toggleWeatherPref(bool val) async {
    await service.togglePref();
    setState(() {
      _isWeatherPref = service.isPreferred;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SettingsLayout(
      title: "Usuário",
      showBackButton: true,
      childWidget: Column(
        spacing: 8,
        children: [
          BigIconButton(
            title: "Local",
            description: "Defina seu local para usar os recursos baseados em geolocalização",
            icon: const Icon(Icons.map_rounded, color: Colors.white),
            color: AppColors.primary,
            onPressed: () {
              Navigator.of(context).pushNamed('/location');
            },
          ),
          _loadingWeather
              ? Shimmer.fromColors(
                    baseColor: AppColors.background,
                    highlightColor: AppColors.gray,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 72,
                          color: Colors.white,
                        ),
                      ],
                    ),
              )
              : SettingsSwitch(
            title: "Clima agora",
            description: "Desabilita o widget de clima na tela inicial",
            icon: Icons.cloud,
            value: service.isPreferred,
            onChanged: (val) async => _toggleWeatherPref(val),
          ),
        ],
      ),
    );
  }
}