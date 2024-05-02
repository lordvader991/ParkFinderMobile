import 'package:flutter/material.dart';

class VehiclesScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Vehicles'),
            ),
            body: ListView.builder(
                itemCount: 10, // Replace with the actual number of items in your list
                itemBuilder: (context, index) {
                    return ListTile(
                        title: Text('Vehicle ${index + 1}'),
                        onTap: () {
                            // Handle item tap
                        },
                    );
                },
            ),
        );
    }
}