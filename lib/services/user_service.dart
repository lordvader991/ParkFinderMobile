// UserService
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
      // Consider storing the token if needed for future use
    } catch (e) {
      print('Error al registrar usuario: $e');
      throw Exception('Failed to register user: $e');
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final response = await _apiService.loginUser(email, password);
      final token = response['data']['token'];
      print('Inicio de sesión exitoso: ${response["data"]["message"]}');
      print('Token de autenticación: $token');
      // Consider storing the token (e.g., using TokenProvider)
      return token;
    } catch (e) {
      print('Error al iniciar sesión: $e');
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> updateUser(String token, Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.updateUser(token, userData);
      // Manejar la respuesta según sea necesario
      print('Usuario actualizado exitosamente: ${response["data"]["message"]}');
    } catch (e) {
      print('Error al actualizar usuario: $e');
      throw Exception('Failed to update user: $e');
    }
  }
}
