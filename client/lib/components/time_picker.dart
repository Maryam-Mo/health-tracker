import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:health/constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TimePickerRow extends StatefulWidget {
  @override
  _TimePickerRowState createState() => _TimePickerRowState();
}

class _TimePickerRowState extends State<TimePickerRow> {
  String formattedDateTime = _formatDateTime(DateTime.now());

  @override
  void initState() {
    formattedDateTime = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(minutes: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(formattedDateTime),
        FlatButton(
            onPressed: () {
              DatePicker.showTime12hPicker(context,
                  showTitleActions: true,
                  theme: DatePickerTheme(
                      headerColor: kLightPurpleColor,
                      backgroundColor: kBackgroundColor,
                      itemStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
                  onConfirm: (date) {
                setState(() {
                  formattedDateTime = _formatDateTime(date);
                });
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
            child: Text(
              'Change',
              style: TextStyle(color: kLightPurpleColor),
            )),
      ],
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatDateTime(now);
    setState(() {
      formattedDateTime = formattedTime;
    });
  }

  static String _formatDateTime(DateTime dateTime) {
    return DateFormat('jm').format(dateTime);
  }
}
