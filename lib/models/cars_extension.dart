import 'package:parkfinder/models/cars.dart';

extension CarsExtension on Cars {
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'brand': brand,
      'model': model,
      'year': year,
      'color': color,
      'dimensions': dimensions.toJson(),
      'number_plate': numberPlate,
    };
  }
}
