import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'features/alarm_provider.dart';
import 'app.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // 1. INITIALIZE TIMEZONES (Crucial for alarms)
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.local);

  // 2. ANDROID SETTINGS
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(
    ChangeNotifierProvider(
      create: (context) => AlarmProvider(),
      child: const TravelAlarmApp(),
    ),
  );
}



// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:provider/provider.dart';
// import 'package:travel_alarm_app/features/home_page.dart';
// import 'app.dart';
// import 'features/alarm_provider.dart';
// import 'features/location_page.dart';
// import 'features/screens.dart';
//
// // Create a global instance
//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Android settings
//    AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('@mipmap/ic_launcher');
//
//   // Combine settings
//    InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//   );
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => AlarmProvider(),
//       child: const TravelAlarmApp(),
//     ),
//   );
// }
//
