import 'package:flutter/material.dart';
import 'package:health/components/icon_button.dart';
import 'package:health/components/purple_container.dart';
import 'package:health/constants.dart';
import 'package:health/screens/water_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController animation;
  Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 4).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });
    animation.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                width: 300,
                height: 465,
                color: Colors.white,
              ),
              Positioned(
                bottom: 0,
                child: PurpleContainerWithShadows(
                  width: 300,
                  height: 400,
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  column: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 120,
                      ),
                      Text(
                        'Welcome To',
                        style: kHeadlineTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Health Tracker',
                        style: kHeadlineTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Color(0xFFF29C9F),
                        thickness: 2,
                        indent: 120,
                        endIndent: 120,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Where your health is beyond importance',
                        style: kTextTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  border: Border.all(
                    width: 0.1,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 150,
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
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFF2F5FE),
                      const Color(0xFFABAABF),
                    ],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  color: Colors.white,
                ),
                child: FadeTransition(
                  opacity: _fadeInFadeOut,
                  child: Image(
                    color: Color(0xFFF29C9F),
                    image: AssetImage(
                      'images/Heart.png',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  WhiteIconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, WaterScreen.id);
                    },
                    text: '',
                    icon: Image(
                      image: AssetImage(
                        'images/Water.png',
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
