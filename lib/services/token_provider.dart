import 'package:flutter/material.dart';

class TokenProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;

  set token(String? value) {
    _token = value;
    notifyListeners();
  }

  // Método para limpiar el token
  void clearToken() {
    _token = null;
    notifyListeners();
  }
}
