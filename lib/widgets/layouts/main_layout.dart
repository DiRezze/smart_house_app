import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_app/theme/app_colors.dart';

class MainAppLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const MainAppLayout({
    required this.child,
    required this.currentIndex,
    required this.onTabSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(child: child),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade800,
                width: 1,
              ),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.navBackground,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.gray,
            type: BottomNavigationBarType.fixed,
            iconSize: 24,
            enableFeedback: false,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            currentIndex: currentIndex,
            onTap: onTabSelected,
            items: const [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Início'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: 'Perfil'),
              BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Configurações'),
            ],
          ),
        ),
      ),
    );
  }
}
