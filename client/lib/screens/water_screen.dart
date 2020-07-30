import 'package:flutter/material.dart';
import 'package:health/components/icon_button.dart';
import 'package:health/components/purple_container.dart';
import 'package:health/constants.dart';

class WaterScreen extends StatelessWidget {
  static const String id = 'water_screen';

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
