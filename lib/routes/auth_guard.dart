import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGuard extends StatelessWidget {
  final Widget protectedRoute;

  const AuthGuard({super.key, required this.protectedRoute});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return protectedRoute;
        } else {
          Future.microtask(() {
            Navigator.pushReplacementNamed(context, '/login');
          });
          return const SizedBox.shrink();
        }
      },

    );

  }

}
