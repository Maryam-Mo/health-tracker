import 'package:flutter/material.dart';
import 'package:health/constants.dart';
import 'package:health/components/purple_container.dart';

class SmallPurpleContainer extends StatelessWidget {
  SmallPurpleContainer({this.text, this.imageUrl, this.padding});

  final String text;
  final String imageUrl;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding),
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
                    text,
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
                imageUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
