import 'package:flutter/material.dart';
import 'package:smart_house_app/screens/home_page.dart';
import 'package:smart_house_app/screens/profile_page.dart';
import 'package:smart_house_app/screens/settings/settings_page.dart';
import 'package:smart_house_app/widgets/layouts/main_layout.dart';

class MainAppPage extends StatefulWidget {
  const MainAppPage({super.key});

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
    SettingsPage(),
  ];

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
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
