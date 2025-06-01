import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_app/services/auth_service.dart';

class AuthVerifier extends StatelessWidget {
  final Widget child;
  final AuthService authService;

  const AuthVerifier({
    super.key,
    required this.child,
    required this.authService,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasData) {
          Future.microtask(() {
            Navigator.of(context).pushReplacementNamed('/app');
          });
          return const SizedBox.shrink();
        }

        return child;
      },
    );
  }
}
