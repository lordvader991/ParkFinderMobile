import 'package:flutter/material.dart';

class TokenProvider extends ChangeNotifier {
  String? _token;
  String? _userId;
  String? _username;
  String? _role;
  String? _firstName;
  String? _lastName;
  String? _gender;
  String? _dateOfBirth;
  String? _email;
  String? _phone;
  String? _country;
  String? _city;

  String? get token => _token;
  String? get userId => _userId;
  String? get username => _username;
  String? get role => _role;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get gender => _gender;
  String? get dateOfBirth => _dateOfBirth;
  String? get email => _email;
  String? get phone => _phone;
  String? get country => _country;
  String? get city => _city;

  set token(String? value) {
    _token = value;
    notifyListeners();
  }

  set userId(String? value) {
    _userId = value;
    notifyListeners();
  }

  set username(String? value) {
    _username = value;
    notifyListeners();
  }

  set role(String? value) {
    _role = value;
    notifyListeners();
  }

  set firstName(String? value) {
    _firstName = value;
    notifyListeners();
  }

  set lastName(String? value) {
    _lastName = value;
    notifyListeners();
  }

  set gender(String? value) {
    _gender = value;
    notifyListeners();
  }

  set dateOfBirth(String? value) {
    _dateOfBirth = value;
    notifyListeners();
  }

  set email(String? value) {
    _email = value;
    notifyListeners();
  }

  set phone(String? value) {
    _phone = value;
    notifyListeners();
  }

  set country(String? value) {
    _country = value;
    notifyListeners();
  }

  set city(String? value) {
    _city = value;
    notifyListeners();
  }

  void clearToken() {
    _token = null;
    notifyListeners();
  }

  void clearUserData() {
    _userId = null;
    _username = null;
    _role = null;
    _firstName = null;
    _lastName = null;
    _gender = null;
    _dateOfBirth = null;
    _email = null;
    _phone = null;
    _country = null;
    _city = null;
    notifyListeners();
  }
}
