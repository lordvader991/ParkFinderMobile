class Car {
  final String id;
  final String userId;
  final String brand;
  final String model;
  final int year;
  final String color;
  final Map<String, dynamic> dimensions;
  final String numberPlate;

  Car({
    required this.id,
    required this.userId,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.dimensions,
    required this.numberPlate,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['_id'],
      userId: json['user_id'],
      brand: json['brand'],
      model: json['model'],
      year: json['year'],
      color: json['color'],
      dimensions: json['dimensions'],
      numberPlate: json['number_plate'],
    );
  }
}
