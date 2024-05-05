import 'package:flutter/material.dart';
import 'package:parkfinder/services/api_service.dart';
import 'package:parkfinder/services/car_service.dart';
import 'package:parkfinder/views/screen_user/vehicle_register_screen.dart';

class VehiclesScreen extends StatelessWidget {
  final ApiService apiService =
      ApiService(); // Crear una instancia de ApiService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicles'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterVehicleScreen(
                        carService: CarService(
                            apiService), // Crear una instancia de CarService
                        apiService: apiService, // Pasar apiService
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.purple,
                ),
                child: const Text(
                  "Registrar Auto",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Vehicle ${index + 1}'),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
