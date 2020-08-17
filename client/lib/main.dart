import 'package:flutter/material.dart';
import 'package:health/screens/home_screen.dart';
import 'package:health/screens/setting_screen.dart';
import 'package:health/screens/water_screen.dart';

void main() => runApp(Health());

class Health extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        WaterScreen.id: (context) => WaterScreen(),
        SettingScreen.id: (context) => SettingScreen(),
      },
    );
  }
}
