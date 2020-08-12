import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:health/constants.dart';
import 'package:health/screens/water_screen.dart';
import 'package:intl/intl.dart';

class DatePickerRow extends StatefulWidget {
  static DateTime dateTime = DateTime.now();
//  static DateTime dateTime =
//      new DateTime.fromMillisecondsSinceEpoch(1565001901000, isUtc: true);

  @override
  _DatePickerRowState createState() => _DatePickerRowState();
}

class _DatePickerRowState extends State<DatePickerRow> {
  String formattedDate =
      DateFormat('yyyy-MM-dd').format(DatePickerRow.dateTime);
  //  String formattedDate = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(formattedDate),
        FlatButton(
            onPressed: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2019),
                  maxTime: DateTime.now(),
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
                  WaterScreen().createState().createWater(date);
                  DatePickerRow.dateTime = date;
                  formattedDate =
                      DateFormat('yyyy-MM-dd').format(DatePickerRow.dateTime);
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
