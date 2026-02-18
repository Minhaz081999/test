import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'alarm_provider.dart';


// --- HOME SCREEN (ALARM LIST) ---
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../constants/app_colors.dart';
import 'alarm_provider.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import 'alarm_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AlarmProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D0B26),
              Color(0xFF1A164D),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 20),
                Text(
                  "Selected Location",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),

                // Location Bar
                GestureDetector(
                    onTap: () => Provider.of<AlarmProvider>(context, listen: false).fetchLocation(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: Colors.white70),
                        const SizedBox(width: 10),
                        Text(
                          provider.currentLocation,
                          style: const TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 35),
                const Text(
                  "Alarms",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),

                // Alarm List
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.alarms.length,
                    itemBuilder: (context, i) {
                      // TEACHING POINT: 'alarm' is of type 'AlarmData'
                      final alarm = provider.alarms[i];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment:.start,

                              children: [
                                Text(
                                  // FIX: Access alarm.time instead of casting
                                  DateFormat('h:mm a').format(alarm.time).toLowerCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 55,),
                                Text(
                                  // FIX: Access alarm.time instead of casting
                                  DateFormat('EEE d MMM yyyy').format(alarm.time),
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),

                            // Stylized Toggle Switch
                            Switch(
                              value: alarm.isActive,
                              onChanged: (val) {
                                provider.toggleAlarm(i);
                              },
                              activeColor: Colors.white,
                              activeTrackColor: AppColors.accentPurple,
                              inactiveThumbColor: Colors.black,
                              inactiveTrackColor: Colors.white,
                            ),


                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 200, right: 0.1),
        child: SizedBox(
          height: 70,
          width: 100,
          child: FloatingActionButton(
            onPressed: () async {
              TimeOfDay? t = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now()
              );
              if (t != null) {
                final now = DateTime.now();
                provider.addAlarm(DateTime(now.year, now.month, now.day, t.hour, t.minute));
              }
            },
            backgroundColor: AppColors.accentPurple,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }
}


// class HomeScreen extends StatefulWidget {
//    HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<AlarmProvider>(context);
//
//     return Scaffold(
//       // The deep gradient background as seen in Home.png
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF0D0B26), // Deep Navy
//               Color(0xFF1A164D), // Dark Purple/Blue
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),
//                 Text(provider.currentLocation,
//                   style:  TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//
//                 // Custom Search/Location Bar
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Row(
//                     children: [
//                       // Using your custom location icon logic
//                       const Icon(Icons.location_on_outlined, color: Colors.white70),
//                       const SizedBox(width: 10),
//                       Text(
//                         provider.currentLocation.isEmpty
//                             ? "Add your location"
//                             : provider.currentLocation,
//                         style: const TextStyle(color: Colors.white70, fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 35),
//                 const Text(
//                   "Alarms",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//
//                 // Alarm List
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: provider.alarms.length,
//                     itemBuilder: (context, i) {
//                       final alarm = provider.alarms[i];
//                       return Container(
//                         margin: const EdgeInsets.only(bottom: 15),
//                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.08),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   DateFormat('h:mm a').format(alarm as DateTime).toLowerCase(),
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   DateFormat('EEE d MMM yyyy').format(alarm as DateTime),
//                                   style: const TextStyle(
//                                     color: Colors.white54,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             // Stylized Toggle Switch
//                             Switch(
//                               value: alarm.isActive , // You can link this to provider logic later
//                               onChanged: (val) {
//                                 provider.toggleAlarm(i);
//
//                               },
//                               activeColor: AppColors.accentPurple,
//                               activeTrackColor: AppColors.accentPurple.withOpacity(0.4),
//                               inactiveThumbColor: Colors.white,
//                               inactiveTrackColor: Colors.white24,
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//
//       // The Floating Action Button from Home.png
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           TimeOfDay? t = await showTimePicker(
//               context: context,
//               initialTime: TimeOfDay.now()
//           );
//           if (t != null) {
//             final now = DateTime.now();
//             provider.addAlarm(DateTime(now.year, now.month, now.day, t.hour, t.minute));
//           }
//         },
//         backgroundColor: AppColors.accentPurple,
//         shape: const CircleBorder(),
//         child: const Icon(Icons.add, color: Colors.white, size: 30),
//       ),
//     );
//   }
// }