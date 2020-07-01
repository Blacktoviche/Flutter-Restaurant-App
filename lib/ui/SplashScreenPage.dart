import 'dart:async';
import 'package:ecommerce/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'MainPage.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage();

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(PageTransition(
        type: PageTransitionType.fadeIn, child: MainPage()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          WaveWidget(
            config: CustomConfig(
              gradients: [
                [Constants.SUB_COLOR, Constants.MAIN_COLOR],
                [Constants.SUB_COLOR, Constants.SUB_COLOR],
                [Colors.orange, Color(0x66FF9800)],
                [Constants.SUB_COLOR, Color(0x55FFEB3B)]
              ],
              durations: [35000, 19440, 10800, 6000],
              heightPercentages: [0.40, 0.45, 0.49, 0.53],
              blur: MaskFilter.blur(BlurStyle.solid, 10),
              gradientBegin: Alignment.bottomLeft,
              gradientEnd: Alignment.topRight,
            ),
            waveAmplitude: 0,
            backgroundColor: Constants.MAIN_COLOR,
            size: Size(
              double.infinity,
              double.infinity,
            ),
          ),
          Positioned.fill(
              top: 100,
              //right: MediaQuery.of(context).size.width/2-30,
              child: Align(
            alignment: Alignment.center,
            child: Column(
                children: <Widget>[
                  Icon(
                    Icons.restaurant,
                    color: Constants.SUB_COLOR,
                    size: 60,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "مطعمي",
                    style: TextStyle(
                        color: Constants.SUB_COLOR,
                        fontWeight: FontWeight.w700,
                        fontSize: 30),
                  )
                ]
            ),
          )
          ),
          Positioned.fill(
              bottom: 100.0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "ZG Prime",
                  style: TextStyle(color: Constants.DARK_COLOR, fontSize: 20, fontWeight: FontWeight.w800),
                ),
              )
          )
        ],
      ),
    );
  }
}
