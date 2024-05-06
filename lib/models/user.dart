class User {
  final String username;
  final String role;
  final String firstName;
  final String lastName;
  final String gender;
  final String dateOfBirth;
  final String email;
  final String password;
  final int phone;
  final String country;
  final String city;

  User({
    required this.username,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dateOfBirth,
    required this.email,
    required this.password,
    required this.phone,
    required this.country,
    required this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      role: json['role'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      country: json['country'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'role': role,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'email': email,
      'password': password,
      'phone': phone,
      'country': country,
      'city': city,
    };
  }
}
