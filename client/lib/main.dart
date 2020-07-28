import 'package:flutter/material.dart';
import 'package:health/screens/home_screen.dart';

void main() => runApp(Health());

class Health extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
      },
      home: HomeScreen(),
    );
  }
}
