import 'package:flutter/material.dart';

class SettingsLayout extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final Widget childWidget;

  const SettingsLayout({
    super.key,
    required this.title,
    this.showBackButton = false,
    required this.childWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(8),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    childWidget,
                  ],
                ),
              ),
            ),
          ),
          if (showBackButton)
            Positioned(
              top: 8,
              left: 8,
              child: SafeArea(
                child: TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  label: const Text(
                    "Voltar",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    overlayColor: Colors.transparent
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}