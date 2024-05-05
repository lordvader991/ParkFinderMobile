import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parkfinder/models/cars.dart';

class VehicleService {
  final String baseUrl = 'http://192.168.1.3:3000/api/v1/auth/cars';


  Future<List<Cars>> getVehicles(String token) async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Cars> vehicles = body.map((dynamic item) => Cars.fromJson(item)).toList();
      return vehicles;
    } else {
      throw 'Failed to load vehicles';
    }
  }

  Future<Cars> getVehicleById(String id, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Cars.fromJson(jsonDecode(response.body));
    } else {
      throw 'Failed to load vehicle';
    }
  }

Future<void> createRecord(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to post data to API');
    }
  }

  Future<void> deleteVehicleById(String id, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw 'Failed to delete vehicle';
    }
  }
}
