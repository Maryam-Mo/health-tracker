import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health/components/date_picker.dart';
import 'package:health/components/icon_button.dart';
import 'package:health/components/input_formatter.dart';
import 'package:health/components/purple_raised_button.dart';
import 'package:health/components/small_purple_container.dart';
import 'package:health/components/time_picker.dart';
import 'package:health/constants.dart';
import 'package:health/models/water_consumption_request.dart';
import 'package:health/models/water_consumption_response.dart';
import 'package:health/models/water_response.dart';
import 'package:health/screens/setting_screen.dart';
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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      createWater(dateTime);
    });
  }

  void createWater(dateTime) async {
    int date = new DateTime(dateTime.year, dateTime.month, dateTime.day)
        .millisecondsSinceEpoch;
    WaterService waterService = WaterService(url: '/api/water/create');
    waterResponse = await waterService
        .postData(WaterResponse(id: 1, date: date, minConsumption: 2));
    getWaterConsumptions(dateTime);
  }

  void getWaterConsumptions(dateTime) async {
    int date = new DateTime(dateTime.year, dateTime.month, dateTime.day)
        .millisecondsSinceEpoch;
    WaterConsumptionService waterConsumptionService = WaterConsumptionService(
        url: '/api/water/findAllConsumptionsByDate/${date}');
    waterConsumptionResponse = await waterConsumptionService.fetchData();
    _waterConsumption = [];
    if (waterConsumptionResponse != null) {
      setState(() {
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
          SmallPurpleContainer(
            text: 'Water Consumption',
            imageUrl: 'images/Water_drop.png',
            padding: 10,
          ),
          DatePickerRow(),
          Expanded(
            flex: 4,
            child: ListView.builder(
                itemCount: _waterConsumption.length,
                itemBuilder: (context, index) {
                  final item = _waterConsumption[index];
                  return Dismissible(
                    key: Key(item.time),
                    onDismissed: (direction) async {
                      await deleteWaterConsumption(item.time, waterResponse.id);
                      getWaterConsumptions(dateTime);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('$item dismissed'),
                      ));
                    },
                    background: Container(color: Colors.red),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
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
                          SizedBox(
                            width: 60,
                          ),
                          FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                FontAwesomeIcons.trash,
                                color: kDarkPurpleColor,
                              ),
                              label: Text(''))
                        ],
                      ),
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
                  WhiteIconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SettingScreen.id);
                    },
                    text: '',
                    icon: Image(
                      image: AssetImage(
                        'images/Wrench.png',
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
                child: PurpleRaisedButton(
                  name: 'Submit',
                  onPressed: () async {
                    WaterConsumptionRequest waterConsumption =
                        new WaterConsumptionRequest(
                            waterId: waterResponse.id,
                            time:
                                TimePickerRow().createState().formattedDateTime,
                            consumption: double.parse(myController.text));
                    await createWaterConsumption(waterConsumption);
                    Navigator.pushNamed(context, WaterScreen.id);
                  },
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
  return waterConsumptionResponse;
}

Future<WaterConsumptionResponse> deleteWaterConsumption(time, waterId) async {
  WaterConsumptionRequest waterConsumption = new WaterConsumptionRequest(
      waterId: waterId, time: time, consumption: 0.0);
  WaterConsumptionService waterConsumptionService =
      WaterConsumptionService(url: '/api/water/deleteWaterConsumption');
  WaterConsumptionResponse waterConsumptionResponse =
      await waterConsumptionService.postData(waterConsumption);
  return waterConsumptionResponse;
}
