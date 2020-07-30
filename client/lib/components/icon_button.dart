import 'package:flutter/material.dart';

class WhiteIconButton extends StatelessWidget {
  WhiteIconButton({this.onPressed, this.text, this.icon});

  final Function onPressed;
  final String text;
  final Image icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        child: FlatButton.icon(
          onPressed: onPressed,
          icon: Container(
            child: icon,
            height: 40,
            width: 40,
          ),
          label: Text(text),
        ),
      ),
    );
  }
}
