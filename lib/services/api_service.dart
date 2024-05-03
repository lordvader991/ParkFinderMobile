import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://10.26.13.20:3000/api/v1/";

  ApiService();

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    final String path = "users/";

    final response = await http.post(
      Uri.parse(baseUrl + path),
      body: jsonEncode(userData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create user: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final String path = "login/";

    final response = await http.post(
      Uri.parse(baseUrl + path),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }
}
