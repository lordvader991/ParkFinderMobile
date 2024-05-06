import 'package:flutter/material.dart';
import 'package:parkfinder/services/car_service.dart';
import 'package:parkfinder/services/token_provider.dart';
import 'package:parkfinder/views/screen_user/vehicle_register_screen.dart';
import 'package:provider/provider.dart';
import 'vehicle_details_screen.dart';

class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({Key? key}) : super(key: key);

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  final VehicleService _vehicleService = VehicleService();
  late List<Map<String, dynamic>> _vehicles = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      String? token = Provider.of<TokenProvider>(context, listen: false).token;
      if (token != null) {
        List<Map<String, dynamic>> vehicles =
            await _vehicleService.getVehicles(token);
        setState(() {
          _vehicles = vehicles;
        });
      } else {
        print('Token is null');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

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
                      builder: (context) => RegisterVehicleScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.purple,
                ),
                child: const Text(
                  "Register car",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: _vehicles.isEmpty
                ? Center(
                    child: Text(
                      'No vehicles registered',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: _vehicles.length,
                    itemBuilder: (context, index) {
                      final vehicle = _vehicles[index];
                      return GestureDetector(
                        onTap: () {
                          // Aquí puedes manejar la lógica para editar el vehículo seleccionado
                          print('Selected vehicle ID: ${vehicle['_id']}');
                          // Por ejemplo, podrías navegar a una pantalla de edición pasando el ID del vehículo
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VehicleDetails(vehicleId: vehicle['_id']),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Icon(Icons.car_rental, size: 50),
                          title: Text(
                            '${vehicle['brand']} ${vehicle['model']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(vehicle['number_plate'] ??
                              'Number plate not available'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              try {
                                String? token = Provider.of<TokenProvider>(
                                        context,
                                        listen: false)
                                    .token;
                                print('Token: $token');
                                String vehicleId = vehicle['_id'];
                                print('Vehicle ID: $vehicleId');
                                await _vehicleService.deleteVehicle(
                                    vehicleId, token!);
                                setState(() {
                                  _vehicles.removeAt(index);
                                });
                              } catch (error) {
                                print('Error deleting vehicle: $error');
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
