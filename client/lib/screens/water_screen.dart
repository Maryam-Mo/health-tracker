import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health/components/date_picker.dart';
import 'package:health/components/icon_button.dart';
import 'package:health/components/input_formatter.dart';
import 'package:health/components/purple_container.dart';
import 'package:health/components/time_picker.dart';
import 'package:health/constants.dart';
import 'package:health/models/water_consumption_request.dart';
import 'package:health/models/water_consumption_response.dart';
import 'package:health/models/water_response.dart';
import 'package:health/services/Networking.dart';
import 'package:health/services/water_consumption_service.dart';
import 'package:health/services/water_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WaterScreen extends StatefulWidget {
  static const String id = 'water_screen';

  @override
  _WaterScreenState createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  List<Map<String, double>> _waterConsumption = [];
  static DateTime dateTime = DateTime.now();
  WaterResponse waterResponse = null;

  @override
  void initState() {
    super.initState();
    createWater(dateTime);
    var map = {'12pm': 2.0};
    _waterConsumption.add(map);
  }

  void createWater(dateTime) async {
    int date = new DateTime(dateTime.year, dateTime.month, dateTime.day)
        .millisecondsSinceEpoch;
    WaterService waterService = WaterService(url: '/api/water/create');
    waterResponse = await waterService
        .postData(WaterResponse(id: 1, date: date, minConsumption: 2));
    print(waterResponse.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                Container(
                  width: 330,
                  height: 190,
                  color: kBackgroundColor,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: PurpleContainerWithShadows(
                    width: 320,
                    height: 180,
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    column: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 110,
                        ),
                        Text(
                          'Water Consumption',
                          style: kTitleTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                    border: Border.all(
                      width: 0.3,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                    color: kBackgroundColor,
                  ),
                  child: Image(
                    color: Color(0xFFF29C9F),
                    image: AssetImage(
                      'images/Water_drop.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
          DatePickerRow(),
          Expanded(
            flex: 4,
            child: ListView.builder(
                itemCount: _waterConsumption.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: Row(
                      children: <Widget>[
                        Text(
                            _waterConsumption[index].keys.first + ' consumed '),
                        Text(_waterConsumption[index].values.first.toString() +
                            'Liter'),
                      ],
                    ),
                  );
                }),
          ),
          Expanded(
            flex: 1,
            child: Scaffold(
              backgroundColor: kBackgroundColor,
              floatingActionButton: new FloatingActionButton(
                onPressed: () {
                  _settingModalBottomSheet(context, dateTime);
                },
                child: new Icon(Icons.add),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  WhiteIconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: '',
                    icon: Image(
                      image: AssetImage(
                        'images/Home.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _settingModalBottomSheet(context, now) {
  final myController = TextEditingController();
  final _amountValidator = RegExInputFormatter.withRegex(
      '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');

  Future<void> future = showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: 360,
          child: Wrap(
            children: <Widget>[
              TimePickerRow(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Enter consumed water:',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      width: 50,
                      child: TextField(
                          controller: myController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true, signed: true),
                          textInputAction: TextInputAction.done,
                          inputFormatters: [_amountValidator]),
                    ),
                    Text(
                      'Liter(s)',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child: ButtonTheme(
                  height: 40,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    elevation: 20,
                    color: kLightPurpleColor,
                    onPressed: () async {
                      WaterConsumptionRequest waterConsumption =
                          new WaterConsumptionRequest(
                              waterConsumptionId: 1,
                              waterId:
                                  WaterScreen().createState().waterResponse.id,
                              time: TimePickerRow().createState().formattedTime,
                              consumption: double.parse(myController.text));
                      WaterConsumptionResponse response =
                          await createWaterConsumption(waterConsumption);
                      Navigator.pop(context);
                    },
                    child: Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        );
      });
//  future.then((void value) => _closeModal(value));
}

Future<WaterConsumptionResponse> createWaterConsumption(
    waterConsumption) async {
  WaterConsumptionService waterConsumptionService =
      WaterConsumptionService(url: '/api/water/createWaterConsumption');
  WaterConsumptionResponse waterConsumptionResponse =
      await waterConsumptionService.postData(waterConsumption);
  print(waterConsumptionResponse);
  return waterConsumptionResponse;
}
