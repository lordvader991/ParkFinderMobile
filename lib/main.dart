import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parkfinder/views/login_screen.dart';
import 'package:parkfinder/views/screen_user/vehicle_register_screen.dart';
import 'package:provider/provider.dart';
import 'package:parkfinder/services/token_provider.dart';
import 'package:parkfinder/views/screen_user/garage_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          TokenProvider(), // Crea una instancia de TokenProvider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ParkFinder',
        home: LoginPage(),
      ),
    );
  }
}
