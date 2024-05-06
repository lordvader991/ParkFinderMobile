// ApiService
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://parkfinder.onrender.com/api/v1/";

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
          throw Exception(
              'Username or email already exists, please use another one.');
        }
      } catch (e) {
        errorMessage = "Unknown error occurred";
      }
      throw Exception(
          'Failed to create user: ${response.statusCode}, Error: $errorMessage');
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

  Future<Map<String, dynamic>> logoutUser() async {
    final String path = "logout/";

    final response = await http.post(
      Uri.parse(baseUrl + path),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to logout: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getUserData(String token) async {
    final String path = "auth/users/me";

    final response = await http.get(
      Uri.parse(baseUrl + path),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user data: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> updateUser(
      String token, Map<String, dynamic> userData) async {
    final String path =
        "auth/users/me"; // Ruta para actualizar datos del usuario actual

    final response = await http.put(
      Uri.parse(baseUrl + path),
      body: jsonEncode(userData),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update user: ${response.statusCode}');
    }
  }

  Future<http.Response> get(String path) async {
    final response = await http.get(Uri.parse(baseUrl + path));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to get data from API: ${response.statusCode}');
    }
  }

  Future<http.Response> post(String path, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    final response = await http.post(
      Uri.parse(baseUrl + path),
      body: jsonEncode(body),
      headers: headers ?? {'Content-Type': 'application/json'},
    );
    return response;
  }
}
