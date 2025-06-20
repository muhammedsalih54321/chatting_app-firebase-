import 'package:chat_app/models/user_moder.dart';
import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class Authprovider with ChangeNotifier {
  final AuthController _authController = AuthController();
  UserModel? _user;

  UserModel? get user => _user;

  // ✅ LOGIN METHOD — MUST BE HERE
  Future<bool> login(String email, String password) async {
    final loggedInUser = await _authController.login(email, password);
    if (loggedInUser != null) {
      _user = loggedInUser;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String email, String password,String name) async {
    final registeredUser = await _authController.register(email, password,name);
    if (registeredUser != null) {
      _user = registeredUser;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout(BuildContext context) async {
    await _authController.logout(context);
    _user = null;
    notifyListeners();
  }
  // ✅ Forgot Password
  Future<void> forgotPassword(String email) async {
    await _authController.forgotPassword(email);
  }
}
