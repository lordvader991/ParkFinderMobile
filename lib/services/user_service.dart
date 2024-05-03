import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_service.dart';
import 'package:parkfinder/models/user.dart';

class UserService {
  final ApiService _apiService;

  UserService(this._apiService);

  Future<void> registerUser(User user) async {
    final Map<String, dynamic> userData = user.toJson();

    try {
      final response = await _apiService.createUser(userData);
      print('Usuario registrado exitosamente: ${response["data"]["message"]}');
      print('Token de autenticación: ${response["data"]["token"]}');
    } catch (e) {
      print('Error al registrar usuario: $e');
      throw Exception('Failed to register user: $e');
    }
  }
}
