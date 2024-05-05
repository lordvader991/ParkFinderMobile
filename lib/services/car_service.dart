import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parkfinder/models/cars.dart';
import 'package:parkfinder/services/token_provider.dart';

class CarService {
  final String baseUrl = 'http://192.168.1.3:3000/api/v1/auth/cars';
  final TokenProvider tokenProvider;

  CarService(this.tokenProvider);

  Future<List<Cars>> getCars() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer ${tokenProvider.token}'},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Cars> cars = body.map((dynamic item) => Cars.fromJson(item)).toList();
      return cars;
    } else {
      throw 'Failed to load cars';
    }
  }

  Future<Cars> getCarById(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {'Authorization': 'Bearer ${tokenProvider.token}'},
    );

    if (response.statusCode == 200) {
      return Cars.fromJson(jsonDecode(response.body));
    } else {
      throw 'Failed to load car';
    }
  }

  Future<Cars> createCar(Cars car) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${tokenProvider.token}',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': car.userId,
        'brand': car.brand,
        'model': car.model,
        'year': car.year,
        'color': car.color,
        'dimensions': {
          'height': car.dimensions.height,
          'width': car.dimensions.width,
          'length': car.dimensions.length,
        },
        'number_plate': car.numberPlate,
      }),
    );

    if (response.statusCode == 201) {
      return Cars.fromJson(jsonDecode(response.body));
    } else {
      throw 'Failed to create car';
    }
  }
}
