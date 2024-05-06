import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parkfinder/models/garage.dart';

class GarageService {
  final String baseUrl =
      'https://parkfinder.onrender.com/api/v1/auth/users/garages';

  Future<List<Map<String, dynamic>>> getGarages(String token) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];
        List<Map<String, dynamic>> garages = data.map((item) {
          return {
            '_id': item['_id'],
            '_userId': item['_userId'],
            'state': item['state'],
            'price_hour': item['price_hour'],
            'description': item['description'],
          };
        }).toList();
        return garages;
      } else {
        throw Exception('Failed to load garages: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching garages: $error');
    }
  }

  Future<Garage> getGarageById(String garageId, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$garageId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'OK') {
          return Garage.fromJson(responseData['data']);
        } else {
          throw Exception('Garage not found');
        }
      } else {
        throw Exception(
            'Failed to load garage details: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching garage details: $error');
    }
  }

  Future<void> updateGarage(
      String garageId, Map<String, dynamic> data, String token) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$garageId'),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update garage: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error updating garage: $error');
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

  Future<void> deleteGarage(String garageId, String token) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$garageId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print('Vehicle garage successfully');
      } else {
        throw Exception('Failed to delete garage: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error deleting garage: $error');
    }
  }
}
