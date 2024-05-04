import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://192.168.1.15:3000/api/v1/";

  ApiService();

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
  final String path = "register/";

  final response = await http.post(
    Uri.parse(baseUrl + path),
    body: jsonEncode(userData),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    String errorMessage = "";
    try {
      errorMessage = jsonDecode(response.body)['error'];
      if (errorMessage.contains('duplicate key error')) {
        throw Exception('Username or email already exists, please use another one.');
      }
    } catch (e) {
      errorMessage = "Unknown error occurred";
    }
    throw Exception('Failed to create user: ${response.statusCode}, Error: $errorMessage');
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
