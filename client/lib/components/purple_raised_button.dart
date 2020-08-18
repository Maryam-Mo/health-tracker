import 'package:flutter/material.dart';
import 'package:health/constants.dart';

class PurpleRaisedButton extends StatelessWidget {
  PurpleRaisedButton({this.name, this.onPressed});
  final String name;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 40,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 20,
        color: kLightPurpleColor,
        onPressed: onPressed,
        child: Text(name),
      ),
    );
  }
}
