import 'package:chat_app/core/services/firebase_auth_services.dart';
import 'package:chat_app/core/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/models/user_moder.dart';
import 'package:flutter/material.dart';


class AuthController {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirebaseService _firebaseService = FirebaseService(); // ✅ Initialize Firestore Service

  Future<UserModel?> login(String email, String password) async {
    try {
      User? user = await _authService.login(email, password);
      if (user != null) {
        // You could optionally fetch user data here if needed
        return UserModel(uid: user.uid, email: user.email ?? '');
      }
    } catch (e) {
      print("Login Error: $e");
    }
    return null;
  }

  Future<UserModel?> register(String email, String password,String name) async {
    try {
      User? user = await _authService.register(email, password);
      if (user != null) {
        UserModel userModel = UserModel(uid: user.uid, email: user.email ?? '',name: name);
        
        // ✅ Save to Firestore
        await _firebaseService.saveUserToFirestore(userModel);
        
        return userModel;
      }
    } catch (e) {
      print("Register Error: $e");
    }
    return null;
  }

  Future<void> logout(BuildContext context) async {
    await _authService.logout(context);
  }

   // ✅ Forgot Password method
  Future<void> forgotPassword(String email) async {
    try {
      await _authService.resetPassword(email);
    } catch (e) {
      print("Forgot Password Error: $e");
    }
  }
}
