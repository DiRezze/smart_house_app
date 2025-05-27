import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_house_app/theme/app_colors.dart';


class AuthLayout extends StatelessWidget {

  final Widget child;
  final String pageTitle;

  const AuthLayout({
    super.key,
    required this.child,
    required this.pageTitle,
  });

  @override
  Widget build(BuildContext context) {
    final height70Percent = MediaQuery.of(context).size.height * 0.80;
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/landing.png',
              fit: BoxFit.cover,
            ),

            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),

            Positioned(
              top: 32,
              left: 16,
              child: TextButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.chevron_left, color: Colors.white),
                label: const Text(
                  "Voltar",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: height70Percent,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                child: Column(
                  spacing: 12,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(
                        top: 12,
                        bottom: 12
                      ),
                      child: Text(pageTitle,
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 38
                        ),
                      ),
                    ),

                    Expanded(child: child)

                  ],
                ),
              ),

            ),

          ],
        )
    );
  }

}