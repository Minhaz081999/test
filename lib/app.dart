import 'package:flutter/material.dart';

import 'features/home_page.dart';
import 'features/location_page.dart';
import 'features/screens.dart';


class TravelAlarmApp extends StatelessWidget {
  const TravelAlarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: OnboardingScreen(),
      routes: {
        '/location': (context) => LocationPage(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}