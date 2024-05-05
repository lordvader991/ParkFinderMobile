import 'package:flutter/material.dart';
import 'package:parkfinder/models/cars.dart';
import 'package:parkfinder/services/api_service.dart';
import 'package:parkfinder/services/car_service.dart';
import 'package:parkfinder/services/token_provider.dart';


class RegisterVehicleScreen extends StatefulWidget {
  final CarService carService;
  final ApiService apiService;
  final TokenProvider tokenProvider;

  const RegisterVehicleScreen({
    Key? key,
    required this.carService,
    required this.apiService,
    required this.tokenProvider,
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 60.0),
                const Text(
                  "Vehicle",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Register your vehicle",
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _brandController,
                  decoration: InputDecoration(
                      hintText: "Brand",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.person)),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _modelController,
                  decoration: InputDecoration(
                      hintText: "Model",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.person)),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Year",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.person)),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _colorController,
                  decoration: InputDecoration(
                      hintText: "Color",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.phone)),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Height",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.phone)),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _widthController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Width",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.phone)),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _lengthController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Length",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.phone)),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _numberPlateController,
                  decoration: InputDecoration(
                      hintText: "Number Plate",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.phone)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _registerVehicle();
                  },
                  child: const Text(
                    "Register Vehicle",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _registerVehicle() async {
    final car = Cars(
      userId: widget.tokenProvider.userId ?? '',
      brand: _brandController.text,
      model: _modelController.text,
      year: int.parse(_yearController.text),
      color: _colorController.text,
      dimensions: Dimensions(
        height: int.parse(_heightController.text),
        width: int.parse(_widthController.text),
        length: int.parse(_lengthController.text),
      ),
      numberPlate: _numberPlateController.text,
    );

    try {
      final newCar = await widget.carService.createCar(car);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: Text('Vehicle registered with ID: ${newCar.id}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to register vehicle: $e'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
