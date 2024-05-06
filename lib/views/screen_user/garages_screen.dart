import 'package:flutter/material.dart';
import 'package:parkfinder/services/garage_service.dart';
import 'package:parkfinder/views/screen_user/garage_register_screen.dart';
import 'package:parkfinder/services/token_provider.dart';
import 'package:provider/provider.dart';

class GaragesScreen extends StatefulWidget {
  const GaragesScreen({Key? key}) : super(key: key);

  @override
  State<GaragesScreen> createState() => _GaragesScreenState();
}

class _GaragesScreenState extends State<GaragesScreen> {
  final GarageService _garageService = GarageService();
  late List<Map<String, dynamic>> _garages = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      String? token = Provider.of<TokenProvider>(context, listen: false).token;
      if (token != null) {
        List<Map<String, dynamic>> garages = await _garageService.getGarages(token);
        setState(() {
          _garages = garages;
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
        title: Text('Garages'),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterGarageScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.purple,
              ),
              child: const Text(
                "Registrar Garaje",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _garages.isEmpty
                ? Center(
                    child: Text(
                      'No tienes garajes registrados',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: _garages.length,
                    itemBuilder: (context, index) {
                      final garage = _garages[index];
                      return ListTile(
                        title: Text(garage['description'] ?? 'Garage ${index + 1}'),
                        subtitle: Text('State: ${garage['state']}, Price_hour: ${garage['price_hour']}'),
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
