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
import 'package:health/services/water_consumption_service.dart';
import 'package:health/services/water_service.dart';

class WaterScreen extends StatefulWidget {
  static const String id = 'water_screen';

  @override
  _WaterScreenState createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  List<WaterConsumption> _waterConsumption = [];
  static DateTime dateTime = DateTime.now();
  WaterResponse waterResponse = null;
  WaterConsumptionResponse waterConsumptionResponse = null;

  @override
  void initState() {
    super.initState();
    createWater(dateTime);
    getWaterConsumptions(dateTime);
  }

  void createWater(dateTime) async {
    int date = new DateTime(dateTime.year, dateTime.month, dateTime.day)
        .millisecondsSinceEpoch;
    WaterService waterService = WaterService(url: '/api/water/create');
    waterResponse = await waterService
        .postData(WaterResponse(id: 1, date: date, minConsumption: 2));
  }

  void getWaterConsumptions(dateTime) async {
    int date = new DateTime(dateTime.year, dateTime.month, dateTime.day)
        .millisecondsSinceEpoch;
    WaterConsumptionService waterConsumptionService = WaterConsumptionService(
        url: '/api/water/findAllConsumptionsByDate/${date}');
    waterConsumptionResponse = await waterConsumptionService.fetchData();
    print(waterConsumptionResponse.waterConsumptions);
    if (waterConsumptionResponse != null) {
      setState(() {
        _waterConsumption = [];
        _waterConsumption.addAll(waterConsumptionResponse.waterConsumptions);
      });
    }
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
                          _waterConsumption[index].time + ' consumed ',
                          style: kListViewTextStyle,
                        ),
                        Text(
                          _waterConsumption[index].consumption.toString() +
                              ' Liter',
                          style: kListViewTextStyle,
                        ),
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
                backgroundColor: kLightPurpleColor,
                onPressed: () {
                  _settingModalBottomSheet(context, dateTime, waterResponse);
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

void _settingModalBottomSheet(context, dateTime, waterResponse) {
  final myController = TextEditingController();
  final _amountValidator = RegExInputFormatter.withRegex(
      '^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');

  showModalBottomSheet(
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
                              waterId: waterResponse.id,
                              time: TimePickerRow().createState().formattedTime,
                              consumption: double.parse(myController.text));
                      await createWaterConsumption(waterConsumption);
                      WaterScreen()
                          .createState()
                          .getWaterConsumptions(dateTime);
                      Navigator.pushNamed(context, WaterScreen.id);
                    },
                    child: Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

Future<WaterConsumptionResponse> createWaterConsumption(
    waterConsumption) async {
  WaterConsumptionService waterConsumptionService =
      WaterConsumptionService(url: '/api/water/createWaterConsumption');
  WaterConsumptionResponse waterConsumptionResponse =
      await waterConsumptionService.postData(waterConsumption);
  print(waterConsumptionResponse.waterConsumptions);
  return waterConsumptionResponse;
}
