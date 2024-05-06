class Dimensions {
  final int height;
  final int width;
  final int length;

  Dimensions({
    required this.height,
    required this.width,
    required this.length,
  });
  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'width': width,
      'length': length,
    };
  }

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      height: json['height'],
      width: json['width'],
      length: json['length'],
    );
  }
}

class Cars {
  final String? id;
  final String userId;
  final String brand;
  final String model;
  final int year;
  final String color;
  final Dimensions dimensions;
  final String numberPlate;

  Cars({
    this.id,
    required this.userId,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.dimensions,
    required this.numberPlate,
  });

  factory Cars.fromJson(Map<String, dynamic> json) {
    return Cars(
      id: json['_id'],
      userId: json['user_id'],
      brand: json['brand'],
      model: json['model'],
      year: json['year'],
      color: json['color'],
      dimensions: Dimensions.fromJson(json['dimensions']),
      numberPlate: json['number_plate'],
    );
  }
}
