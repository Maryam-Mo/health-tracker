import 'package:flutter/material.dart';
import 'package:health/components/small_purple_container.dart';
import 'package:health/constants.dart';

class SettingScreen extends StatelessWidget {
  static const String id = 'setting_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          SmallPurpleContainer(
            text: 'Settings',
            imageUrl: 'images/Wrench.png',
            padding: 40,
          ),
        ],
      ),
    );
  }
}
