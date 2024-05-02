import 'package:flutter/material.dart';
import 'package:parkfinder/views/screen_user/garage_register_screen.dart';

class GaragesScreen extends StatelessWidget {
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
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                                return ListTile(
                                    title: Text('Garage ${index + 1}'),
                                    onTap: () {
                                    },
                                );
                            },
                        ),
                    ),
                ],
            ),
        );
    }
}
