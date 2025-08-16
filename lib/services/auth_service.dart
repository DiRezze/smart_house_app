import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassWord({
    required String email,
    required String password
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim()
    );
  }

  Future<void> signOut(BuildContext context) async {
    await _firebaseAuth.signOut();
  }

}