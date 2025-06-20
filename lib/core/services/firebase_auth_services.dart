import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> register(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future<User?> login(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }
 // ✅ Forgot Password
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
 

  Future<void> logout(BuildContext context) async {
    await _auth.signOut().then((value) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/login",
        (Route<dynamic> route) => false,
      );
    });
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
