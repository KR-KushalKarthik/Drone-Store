import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  bool _loggedIn = false;
  String _name = 'Guest';

  bool get isLoggedIn => _loggedIn;
  String get name => _name;

  void login({required String name}) {
    _loggedIn = true;
    _name = name.trim().isEmpty ? 'User' : name.trim();
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    _name = 'Guest';
    notifyListeners();
  }
}
