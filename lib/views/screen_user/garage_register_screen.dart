import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:parkfinder/services/garage_service.dart';
import 'package:parkfinder/services/token_provider.dart';
import 'package:provider/provider.dart';

class RegisterGarageScreen extends StatefulWidget {
  const RegisterGarageScreen({Key? key}) : super(key: key);

  @override
  _RegisterGarageScreenState createState() => _RegisterGarageScreenState();
}

class _RegisterGarageScreenState extends State<RegisterGarageScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _priceHourController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final List<TextEditingController> _fromControllers = [];
  final List<TextEditingController> _toControllers = [];
  final List<TextEditingController> _heightControllers = [];
  final List<TextEditingController> _widthControllers = [];
  final List<TextEditingController> _lengthControllers = [];
  final GarageService garageService = GarageService();
  late Size mediaSize;

  late int _spaces = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create your garage'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
              'Garage',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Description',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _latitudeController,
                    decoration: InputDecoration(
                      hintText: 'Latitude',
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _longitudeController,
                    decoration: InputDecoration(
                      hintText: 'Longitude',
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<int>(
              value: _spaces,
              onChanged: (value) {
                setState(() {
                  _spaces = value ?? 1;
                  _updateControllersList(_spaces);
                });
              },
              items: [1, 2].map((spaces) {
                return DropdownMenuItem(
                  value: spaces,
                  child: Text('$spaces Space(s)'),
                );
              }).toList(),
              decoration: InputDecoration(
                hintText: 'Number of Spaces',
                prefixIcon: Icon(Icons.place),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            SizedBox(height: 20),
            for (int i = 0; i < _spaces; i++) ...[
              _buildPlaceFormField(i + 1),
              SizedBox(height: 20),
            ],
            SizedBox(height: 20),
            TextField(
              controller: _priceHourController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Price per Hour',
                prefixIcon: Icon(Icons.money),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _stateController.text.isNotEmpty
                  ? _stateController.text
                  : null,
              onChanged: (value) {
                setState(() {
                  _stateController.text = value!;
                });
              },
              items: ['available', 'taken'].map((state) {
                return DropdownMenuItem(
                  value: state,
                  child: Text(state),
                );
              }).toList(),
              decoration: InputDecoration(
                hintText: 'State',
                prefixIcon: Icon(Icons.assignment_turned_in),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<int>(
              value: _ratingController.text.isNotEmpty
                  ? int.parse(_ratingController.text)
                  : null,
              onChanged: (value) {
                setState(() {
                  _ratingController.text = value.toString();
                });
              },
              items: [0, 1, 2, 3, 4, 5].map((rating) {
                return DropdownMenuItem(
                  value: rating,
                  child: Text('$rating'),
                );
              }).toList(),
              decoration: InputDecoration(
                hintText: 'Rating',
                prefixIcon: Icon(Icons.star),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final tokenProvider =
                    Provider.of<TokenProvider>(context, listen: false);
                final authToken = tokenProvider.token;
                print('Token: $authToken');
                Map<String, dynamic> requestBody = {
                  'description': _descriptionController.text,
                  'coordinates': {
                    'latitude': _latitudeController.text,
                    'longitude': _longitudeController.text,
                  },
                  'places': List.generate(_spaces, (index) {
                    return {
                      'place_number': index + 1,
                      'dimensions': {
                        'height': double.parse(_heightControllers[index].text),
                        'width': double.parse(_widthControllers[index].text),
                        'length': double.parse(_lengthControllers[index].text),
                      },
                    };
                  }),
                  'schedule': [
                    for (int i = 0; i < _spaces; i++)
                      {
                        'weekdays': 'Monday',
                        'periods': [
                          {
                            'from': _fromControllers[i].text,
                            'to': _toControllers[i].text,
                          },
                        ],
                      },
                  ],
                  'price_hour': int.parse(_priceHourController.text),
                  'state': _stateController.text,
                  'rating': double.parse(_ratingController.text),
                };
                final response = await http.post(
                  Uri.parse(
                      'https://parkfinder.onrender.com/api/v1/auth/users/garages'),
                  body: jsonEncode(requestBody),
                  headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer $authToken'
                  },
                );
                print(response.body);
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Registered vehicle successfully!'),
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to register vehicle'),
                    ),
                  );
                }
              },
              child: Text(
                'Registrar',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceFormField(int placeNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Place $placeNumber',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _heightControllers.length > placeNumber - 1
                    ? _heightControllers[placeNumber - 1]
                    : TextEditingController(),
                decoration: InputDecoration(
                  hintText: 'Height',
                  prefixIcon: Icon(Icons.height),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: TextField(
                controller: _widthControllers.length > placeNumber - 1
                    ? _widthControllers[placeNumber - 1]
                    : TextEditingController(),
                decoration: InputDecoration(
                  hintText: 'Width',
                  prefixIcon: Icon(Icons.straighten),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        TextField(
          controller: _lengthControllers.length > placeNumber - 1
              ? _lengthControllers[placeNumber - 1]
              : TextEditingController(),
          decoration: InputDecoration(
            hintText: 'Length',
            prefixIcon: Icon(Icons.straighten),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _fromControllers.length > placeNumber - 1
                    ? _fromControllers[placeNumber - 1]
                    : TextEditingController(),
                decoration: InputDecoration(
                  hintText: 'From',
                  prefixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onTap: () {
                  _selectTime(context, _fromControllers[placeNumber - 1]);
                },
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: TextField(
                controller: _toControllers.length > placeNumber - 1
                    ? _toControllers[placeNumber - 1]
                    : TextEditingController(),
                decoration: InputDecoration(
                  hintText: 'To',
                  prefixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onTap: () {
                  _selectTime(context, _toControllers[placeNumber - 1]);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        DropdownButtonFormField<String>(
          value: 'Monday',
          onChanged: (value) {
            setState(() {});
          },
          items: [
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday'
          ].map((day) {
            return DropdownMenuItem(
              value: day,
              child: Text(day),
            );
          }).toList(),
          decoration: InputDecoration(
            hintText: 'Weekday',
            prefixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  void _updateControllersList(int spaces) {
    while (_heightControllers.length < spaces) {
      _heightControllers.add(TextEditingController());
      _widthControllers.add(TextEditingController());
      _lengthControllers.add(TextEditingController());
      _fromControllers.add(TextEditingController());
      _toControllers.add(TextEditingController());
    }
    while (_heightControllers.length > spaces) {
      _heightControllers.removeLast();
      _widthControllers.removeLast();
      _lengthControllers.removeLast();
      _fromControllers.removeLast();
      _toControllers.removeLast();
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      final formattedDate = DateFormat("yyyy-MM-dd").format(picked);
      controller.text = formattedDate;
    }
  }
}
