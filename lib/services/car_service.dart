import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parkfinder/models/cars.dart';
import 'package:parkfinder/services/api_service.dart';

class CarService {
  final ApiService _apiService;

  CarService(this._apiService);

  Future<List<Car>> getAllCars() async {
    try {
      final response = await _apiService.get("cars");
      if (response.statusCode == 200) {
        final List<dynamic> carData = jsonDecode(response.body);
        return carData.map((json) => Car.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch cars');
      }
    } catch (error) {
      throw Exception('Failed to fetch cars: $error');
    }
  }

  Future<Car> getCarById(String carId) async {
    try {
      final response = await _apiService.get("cars/$carId");
      if (response.statusCode == 200) {
        final Map<String, dynamic> carData = jsonDecode(response.body);
        return Car.fromJson(carData);
      } else {
        throw Exception('Failed to fetch car');
      }
    } catch (error) {
      throw Exception('Failed to fetch car: $error');
    }
  }

  Future<Car> createCar(Map<String, dynamic> carData, String userId) async {
    try {
      final response = await _apiService.post(
        "auth/cars",
        carData,
        headers: {'Authorization': 'Bearer $userId'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return Car.fromJson(responseData);
      } else {
        throw Exception('Failed to create car');
      }
    } catch (error) {
      throw Exception('Failed to create car: $error');
    }
  }
}
