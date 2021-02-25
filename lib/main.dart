import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:tafseer_app/screens/OnBoarding/OnBoarding_Welcome.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  /// OneSignal Initialization
  void initOneSignal(oneSignalAppId) {
    var settings = {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.inAppLaunchUrl: true
    };
    OneSignal.shared.init(oneSignalAppId, iOSSettings: settings);
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
// will be called whenever a notification is received
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      print('Received: ' + notification?.payload?.body ?? '');
    });
// will be called whenever a notification is opened/button pressed.
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print('Opened: ' + result.notification?.payload?.body ?? '');
    });
  }

  initOneSignal("15387483-42f7-408a-b2fa-a5127b7670c9");
  runApp(TafseerApp());
}

class TafseerApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _TafseerAppState createState() => _TafseerAppState();
}

class _TafseerAppState extends State<TafseerApp> {
  void initState() {
    super.initState();
  }

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
