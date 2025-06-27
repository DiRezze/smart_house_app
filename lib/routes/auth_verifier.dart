import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_app/services/auth_service.dart';

class AuthVerifier extends StatefulWidget {
  final Widget child;
  final AuthService authService;

  const AuthVerifier({
    super.key,
    required this.child,
    required this.authService,
  });

  @override
  State<AuthVerifier> createState() => _AuthVerifierState();
}

class _AuthVerifierState extends State<AuthVerifier> {
  bool _navigated = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: widget.authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasData && !_navigated) {
          _navigated = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              Navigator.of(context).pushReplacementNamed('/app');
            }
          });
          return const SizedBox.shrink();
        }

        return widget.child;
      },
    );
  }
}