import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHandler {
  static const String apiUrl = 'http://10.26.3.167:3000/api/v1';

  static Future<Map<String, dynamic>> signUp(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$apiUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign up');
    }
  }
}
