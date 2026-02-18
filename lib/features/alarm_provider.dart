import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:travel_alarm_app/main.dart';

class AlarmData {
  DateTime time;
  bool isActive;
  AlarmData({required this.time, this.isActive = true});
}

class AlarmProvider extends ChangeNotifier {

  String _currentLocation = "Add your location";
  List<AlarmData> _alarms = [];

  String get currentLocation => _currentLocation;
  List<AlarmData> get alarms => _alarms;

  // Global instance for notifications
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> fetchLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied) {
      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> marks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      _currentLocation = "${marks[0].locality}, ${marks[0].country}";
      notifyListeners();
    }
  }

  void addAlarm(DateTime dt) {
    _alarms.add(AlarmData(time: dt));
    _scheduleNotification(dt, _alarms.length);
    notifyListeners();
  }

  void toggleAlarm(int index) {
    _alarms[index].isActive = !_alarms[index].isActive;
    if (!_alarms[index].isActive) {
      _notificationsPlugin.cancel(index); // Cancel notification if turned off
      _scheduleNotification(_alarms[index].time, index);
       _showNotification(index);
      _showNotificationWithDelay(_alarms[index].time, index);
    } else {
   print('object');
    }
    notifyListeners();
  }
  // instant show notification kaj kore with two parameters
  Future<void> _showNotificationWithDelay(DateTime scheduledTime, int id) async {

    if (scheduledTime.isBefore(DateTime.now())) return;

    final difference = scheduledTime.difference(DateTime.now());

    await Future.delayed(difference);

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'alarm_channel_id',
      'Alarm Notifications',
      channelDescription: 'Channel for Travel Alarms',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      id,
      'Alarm Ringing!',
      'Time for your travel event!',
      platformDetails,
    );
    notifyListeners();
  }

  // instant show notification kaj kore with one parameter
  Future<void> _showNotification(int id) async {

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'alarm_channel_id',
      'Alarm Notifications',
      channelDescription: 'Channel for Travel Alarms',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      id,
      'Alarm Ringing is turned off!',
      "",
      platformDetails,
    );
    notifyListeners();
  }

// schedule notification
  Future<void> _scheduleNotification(DateTime scheduledTime, int id) async {
    // Initialize timezone database
    tz.initializeTimeZones();

    tz.setLocalLocation(tz.local);

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'alarm_channel_id',
      'Alarm Notifications',
      channelDescription: 'Channel for Travel Alarms',
      importance: Importance.max,
      priority: Priority.high,
    );
    // Inside your AlarmProvider or Main
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>();


    await androidImplementation?.requestNotificationsPermission();
    await androidImplementation?.requestExactAlarmsPermission();
// This triggers the system popup
    await androidImplementation?.requestNotificationsPermission();
    await androidImplementation?.requestExactAlarmsPermission();

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    if (scheduledTime.isBefore(DateTime.now())) return;

    // Correct way to schedule using timezones
    await _notificationsPlugin.zonedSchedule(
      id,
      'Alarm Ringing!',
      'Time for your travel event!',
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

    );
    notifyListeners();
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
//
// // New class to store both the time and the switch status
// class AlarmData {
//   DateTime time;
//   bool isActive;
//
//   AlarmData({required this.time, this.isActive = true});
// }
//
// class AlarmProvider extends ChangeNotifier {
//   String _currentLocation = "Add your location";
//
//   // Updated list to use the AlarmData class
//   List<AlarmData> _alarms = [];
//
//   String get currentLocation => _currentLocation;
//   List<AlarmData> get alarms => _alarms;
//
//   Future<void> fetchLocation() async {
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission != LocationPermission.denied) {
//       Position pos = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high
//       );
//       List<Placemark> marks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
//       _currentLocation = "${marks[0].locality}, ${marks[0].country}";
//       notifyListeners();
//     }
//   }
//
//   // Updated to add an AlarmData object
//   void addAlarm(DateTime dt) {
//     _alarms.add(AlarmData(time: dt));
//     _scheduleNotification(dt, _alarms.length); // Schedule it!
//     notifyListeners();
//   }
//
//   // NEW: Function to handle the switch toggle
//   void toggleAlarm(int index) {
//     _alarms[index].isActive = !_alarms[index].isActive;
//     notifyListeners(); // This triggers the UI to rebuild immediately
//   }
//   Future<void> _scheduleNotification(DateTime scheduledTime, int id) async {
//     // Basic Notification Details
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'alarm_channel_id',
//       'Alarm Notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//       sound: RawResourceAndroidNotificationSound('notification_sound'), // Optional
//     );
//
//     const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);
//
//     // If the time is in the past, don't schedule
//     if (scheduledTime.isBefore(DateTime.now())) return;
//
//     // For a simple test, we show how to display a notification
//     // In a real app, use flutter_native_timezone to schedule exact times
//     await FlutterLocalNotificationsPlugin().show(
//       id,
//       'Alarm Ringing!',
//       'It is time for your travel event: ${scheduledTime.hour}:${scheduledTime.minute}',
//       platformDetails,
//     );
//   }
// }
//
//
// //
// // import 'package:flutter/material.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:geocoding/geocoding.dart';
// //
// // class AlarmProvider extends ChangeNotifier {
// //   String _currentLocation = "Add your location";
// //   List<DateTime> _alarms = [];
// //
// //   String get currentLocation => _currentLocation;
// //   List<DateTime> get alarms => _alarms;
// //
// //   Future<void> fetchLocation() async {
// //     LocationPermission permission = await Geolocator.requestPermission();
// //     if (permission != LocationPermission.denied) {
// //       Position pos = await Geolocator.getCurrentPosition();
// //       List<Placemark> marks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
// //       _currentLocation = "${marks[0].locality}, ${marks[0].country}";
// //       notifyListeners();
// //     }
// //   }
// //
// //   void addAlarm(DateTime dt) {
// //     _alarms.add(dt);
// //     notifyListeners();
// //   }
// // }