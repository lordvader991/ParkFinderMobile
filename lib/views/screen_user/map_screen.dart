import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkfinder/views/screen_user/garage_details.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  bool _isLocationEnabled = false;
  List<Marker> _markers = [];

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

  void _addMarkers() {
    List<LatLng> coordinates = [
      LatLng(-17.677255, -63.141600),
      LatLng(-17.682680, -63.149881),
      LatLng(-17.682186, -63.161723),
      LatLng(-17.691403, -63.159401),
      LatLng(-17.692079, -63.143956),
    ];

    for (int i = 0; i < coordinates.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId('marker$i'),
          position: coordinates[i],
          infoWindow: InfoWindow(title: 'Marker $i'),
          onTap: () {
            _handleMarkerTap(i);
          },
        ),
      );
    }
  }

  void _handleMarkerTap(int markerIndex) {
    // Aquí puedes abrir la pantalla GarageDetails
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GarageDetails()),
    );
  }

  @override
  Widget build(BuildContext context) {
    _addMarkers(); // Agrega los marcadores al inicio

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(0, 0),
            zoom: 11.0,
          ),
          myLocationEnabled: _isLocationEnabled,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          markers: Set<Marker>.from(_markers),
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
