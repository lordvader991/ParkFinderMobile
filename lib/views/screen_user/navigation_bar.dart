import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'profile_screen.dart';
import 'vehicles_screen.dart';
import 'garages_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    MapScreen(),
    ProfileScreen(),
    VehiclesScreen(),
    GaragesScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color.fromARGB(255, 177, 120, 218),
          primaryColor: primaryColor,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.white.withOpacity(0.7)),
              ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.white.withOpacity(0.7),
          selectedItemColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car),
              label: 'My vehicles',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_work),
              label: 'My garages',
            ),
          ],
          backgroundColor: Colors.purple,
          elevation: 20,
          selectedLabelStyle: TextStyle(color: Colors.white),
          unselectedLabelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
      ),
    );
  }
}
