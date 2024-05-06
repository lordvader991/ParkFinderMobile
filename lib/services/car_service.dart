import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parkfinder/models/cars.dart';

class VehicleService {
  final String baseUrl = 'http://10.26.7.216:3000/api/v1/auth/users/cars';
  final String baseUrl2 = 'http://10.26.7.216:3000/api/v1/auth/cars';

  Future<List<Map<String, dynamic>>> getVehicles(String token) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];
        List<Map<String, dynamic>> vehicles = data.map((item) {
          return {
            '_id': item['_id'],
            'brand': item['brand'],
            'model': item['model'],
            'number_plate': item['number_plate'],
          };
        }).toList();
        return vehicles;
      } else {
        throw Exception('Failed to load vehicles: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching vehicles: $error');
    }
  }

  Future<Cars> getVehicleById(String vehicleId, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$vehicleId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'OK') {
          return Cars.fromJson(responseData['data']);
        } else {
          throw Exception('Vehicle not found');
        }
      } else {
        throw Exception(
            'Failed to load vehicle details: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching vehicle details: $error');
    }
  }

  Future<void> updateVehicle(
      String vehicleId, Map<String, dynamic> data, String token) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$vehicleId'),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update vehicle: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error updating vehicle: $error');
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

  Future<void> deleteVehicle(String vehicleId, String token) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl2/$vehicleId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print('Vehicle deleted successfully');
      } else {
        throw Exception('Failed to delete vehicle: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error deleting vehicle: $error');
    }
  }
}
