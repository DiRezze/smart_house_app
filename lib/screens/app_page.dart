import 'package:flutter/material.dart';
import 'package:smart_house_app/screens/home_page.dart';
import 'package:smart_house_app/screens/profile/profile_page.dart';
import 'package:smart_house_app/screens/settings/settings_page.dart';
import 'package:smart_house_app/widgets/layouts/main_layout.dart';

class MainAppPage extends StatefulWidget {
  const MainAppPage({super.key});

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  int _currentIndex = 0;

  final GlobalKey<HomePageState> _homeKey = GlobalKey<HomePageState>();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(key: _homeKey),
      ProfilePage(),
      SettingsPage(),
    ];
  }

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);

    if (index == 0) {
      _homeKey.currentState?.loadDevices();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainAppLayout(
      currentIndex: _currentIndex,
      onTabSelected: _onTabSelected,
      child: _pages[_currentIndex],
    );
  }
}

