import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parkfinder/services/car_service.dart';
import 'package:parkfinder/services/token_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class RegisterVehicleScreen extends StatefulWidget {
  const RegisterVehicleScreen({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterVehicleScreenState createState() => _RegisterVehicleScreenState();
}

class _RegisterVehicleScreenState extends State<RegisterVehicleScreen> {
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _numberPlateController = TextEditingController();
  final VehicleService carService = VehicleService();
  late Size mediaSize;


  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Vehicle'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 60),
              Text(
                'Vehicle',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Register your vehicle',
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _brandController,
                decoration: InputDecoration(
                  hintText: 'Brand',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _modelController,
                decoration: InputDecoration(
                  hintText: 'Model',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _yearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Year',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _colorController,
                decoration: InputDecoration(
                  hintText: 'Color',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Height',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _widthController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Width',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _lengthController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Length',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _numberPlateController,
                decoration: InputDecoration(
                  hintText: 'Number Plate',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.purple.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
                    //final userId = tokenProvider.userId;
                    final authToken = tokenProvider.token;
                    print('Token: $authToken');
                    Map<String, dynamic> requestBody = {
                    //'user_id': userId,
                    'brand': _brandController.text,
                    'model': _modelController.text,
                    'year': int.parse(_yearController.text),
                    'color': _colorController.text,
                    'dimensions': {
                        'height': int.parse(_heightController.text),
                        'width': int.parse(_widthController.text),
                        'length': int.parse(_lengthController.text),
                    },
                    'number_plate': _numberPlateController.text,
                    };
                    final response = await http.post(
                        Uri.parse('http://192.168.1.3:3000/api/v1/auth/cars'),
                        body: jsonEncode(requestBody),
                        headers: {
                            'Content-Type': 'application/json',
                            'Authorization':'Bearer $authToken'
                        },

                    );
                    print(response.body);
                    if (response.statusCode == 200) {
                        Navigator.pop(context);
                    } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Failed to register vehicle'),
                            ),
                        );
                    };
                },
                child: Text(
                  'Register Vehicle',
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
      ),
    );
  }


}
