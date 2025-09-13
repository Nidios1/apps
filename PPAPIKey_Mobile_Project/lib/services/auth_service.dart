import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  final SharedPreferences prefs;
  bool _isAuthenticated = false;

  AuthService(this.prefs) {
    _isAuthenticated = prefs.getBool('is_authenticated') ?? false;
  }

  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login(String username, String password) async {
    // Simulate login logic
    if (username.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
      await prefs.setBool('is_authenticated', true);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    await prefs.setBool('is_authenticated', false);
    notifyListeners();
  }
}