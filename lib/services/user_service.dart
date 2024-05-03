import 'package:parkfinder/services/api_service.dart';
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

  Future<void> login(String email, String password) async {
    try {
      final response = await _apiService.loginUser(email, password);
      print('Inicio de sesión exitoso: ${response["data"]["message"]}');
      print('Token de autenticación: ${response["data"]["token"]}');
    } catch (e) {
      print('Error al iniciar sesión: $e');
      throw Exception('Failed to login: $e');
    }
  }
}