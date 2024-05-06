import 'package:flutter/material.dart';

class GarageDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garage Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoCard(
                icon: Icons.location_on,
                title: 'Location:',
                content: Text(
                  '123 Main Street, City, Country',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              _buildInfoCard(
                icon: Icons.access_time,
                title: 'Hours of Operation:',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Monday - Friday: 9:00 AM - 6:00 PM',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Saturday - Sunday: Closed',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildInfoCard(
                icon: Icons.square_foot,
                title: 'Dimensions:',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Width: 10 meters',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Length: 20 meters',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildInfoCard(
                icon: Icons.local_parking,
                title: 'Parking Spaces:',
                content: Text(
                  'Total: 50',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              _buildInfoCard(
                icon: Icons.attach_money,
                title: 'Price:',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hourly: \$5',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Daily: \$30',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Weekly: \$150',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildInfoCard(
                icon: Icons.check_circle_outline,
                title: 'Availability:',
                content: Text(
                  'Status: Available',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              _buildInfoCard(
                icon: Icons.star,
                title: 'Rating:',
                content: Row(
                  children: [
                    Icon(Icons.star,
                        color: Color.fromRGBO(125, 39, 191, 1), size: 28),
                    Icon(Icons.star,
                        color: Color.fromRGBO(125, 39, 191, 1), size: 28),
                    Icon(Icons.star,
                        color: Color.fromRGBO(125, 39, 191, 1), size: 28),
                    Icon(Icons.star,
                        color: Color.fromRGBO(125, 39, 191, 1), size: 28),
                    Icon(Icons.star_border,
                        color: Color.fromRGBO(125, 39, 191, 1), size: 28),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text('Offer'),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required Widget content,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.purple),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            content,
          ],
        ),
      ),
    );
  }
}
