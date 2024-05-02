import 'package:flutter/material.dart';

class GaragesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garages'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with the actual number of items in your list
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Garage ${index + 1}'),
            onTap: () {
              // Handle item tap here
            },
          );
        },
      ),
    );
  }
}
