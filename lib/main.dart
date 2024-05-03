import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parkfinder/views/login_screen.dart';
import 'package:parkfinder/views/screen_user/map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
