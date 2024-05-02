import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  bool _isLocationEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _checkPermission() async {
    final status = await Permission.locationWhenInUse.status;
    if (status.isDenied) {
      final result = await Permission.locationWhenInUse.request();
      if (result.isGranted) {
        _getCurrentLocation();
      }
    } else if (status.isGranted) {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    print('Current Location: $position');
    setState(() {
      _isLocationEnabled = true;
    });
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(0, 0),
            zoom: 11.0,
          ),
          myLocationEnabled: _isLocationEnabled,
          myLocationButtonEnabled: false,
          zoomControlsEnabled:
              false, // Desactiva los botones de zoom, quitarlo si o si
          zoomGesturesEnabled: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _getCurrentLocation,
          tooltip: 'Mi Ubicación',
          child: Icon(Icons.my_location),
        ),
      ),
    );
  }
}
