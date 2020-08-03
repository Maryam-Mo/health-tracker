import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:health/constants.dart';
import 'package:intl/intl.dart';

class DatePickerRow extends StatefulWidget {
  static DateTime dateTime = DateTime.now();

  @override
  _DatePickerRowState createState() => _DatePickerRowState();
}

class _DatePickerRowState extends State<DatePickerRow> {
  String formattedDate =
      DateFormat('yyyy-MM-dd').format(DatePickerRow.dateTime);

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
