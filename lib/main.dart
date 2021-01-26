import 'package:flutter/material.dart';
import 'package:tafseer_app/screens/OnBoarding/OnBoarding_Welcome.dart';
import 'package:flutter/services.dart';

void main() => runApp(TafseerApp());

class TafseerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return MaterialApp(
      title: 'Flutter Demo',
      home: OnBoardingWelcome(),
    );
  }
}
