class Dimensions {
  int height;
  int width;
  int length;

  Dimensions({required this.height, required this.width, required this.length});

  Map<String, dynamic> toMap() {
    return {
      'height': height,
      'width': width,
      'length': length,
    };
  }

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      height: json['height'] as int,
      width: json['width'] as int,
      length: json['length'] as int,
    );
  }
}

class Place {
  final int placeNumber;
  final Dimensions dimensions;

  Place({
    required this.placeNumber,
    required this.dimensions,
  });

  Map<String, dynamic> toMap() {
    return {
      'place_number': placeNumber,
      'dimensions': dimensions.toMap(),
    };
  }

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeNumber: json['place_number'],
      dimensions: Dimensions.fromJson(json['dimensions']),
    );
  }
}

class Period {
  final DateTime from;
  final DateTime to;

  Period({
    required this.from,
    required this.to,
  });

  Map<String, dynamic> toMap() {
    return {
      'from': from,
      'to': to,
    };
  }

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json['to']),
    );
  }
}

class Schedule {
  String day;
  String from;
  String to;

  Schedule({required this.day, required this.from, required this.to});

  // Método toJson() para convertir el objeto Schedule a un mapa
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'from': from,
      'to': to,
    };
  }

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      day: json['day'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
    );
  }
}

class Coordinates {
  final String latitude;
  final String longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class Garage {
  final String userId;
  final DateTime requestDate;
  final String description;
  final Coordinates coordinates;
  final List<Place> places;
  final List<Schedule> schedule;
  final double? rating;
  final double priceHour;
  final String state;
  final List<String> blockedUsers;

  Garage({
    required this.userId,
    required this.requestDate,
    required this.description,
    required this.coordinates,
    required this.places,
    required this.schedule,
    this.rating,
    required this.priceHour,
    required this.state,
    required this.blockedUsers,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'request_date': requestDate.toIso8601String(),
      'description': description,
      'coordinates': coordinates.toMap(),
      'places': places.map((place) => place.toMap()).toList(),
      'schedule': schedule.map((schedule) => schedule.toJson()).toList(), // Usar toJson() en lugar de toMap()
      'rating': rating,
      'price_hour': priceHour,
      'state': state,
      'blocked_users': blockedUsers,
    };
  }

  factory Garage.fromJson(Map<String, dynamic> json) {
    return Garage(
      userId: json['user_id'],
      requestDate: DateTime.parse(json['request_date']),
      description: json['description'],
      coordinates: Coordinates.fromJson(json['coordinates']),
      places: (json['places'] as List<dynamic>)
          .map((placeJson) => Place.fromJson(placeJson))
          .toList(),
      schedule: (json['schedule'] as List<dynamic>)
          .map((scheduleJson) => Schedule.fromJson(scheduleJson))
          .toList(),
      rating: json['rating'],
      priceHour: json['price_hour'],
      state: json['state'],
      blockedUsers: List<String>.from(json['blocked_users']),
    );
  }
}
