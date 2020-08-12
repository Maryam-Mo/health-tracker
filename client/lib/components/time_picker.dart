import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:health/constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TimePickerRow extends StatefulWidget {
  static DateTime dateTime = DateTime.now();

  @override
  _TimePickerRowState createState() => _TimePickerRowState();
}

class _TimePickerRowState extends State<TimePickerRow> {
  String formattedTime = DateFormat('jm').format(TimePickerRow.dateTime);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(formattedTime),
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
                  TimePickerRow.dateTime = date;
                  formattedTime =
                      DateFormat('jm').format(TimePickerRow.dateTime);
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
}
