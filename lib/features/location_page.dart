import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import 'alarm_provider.dart';

// --- LOCATION PAGE ---
class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Padding(
        padding: const EdgeInsets.only(top: 80,left: 16,right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 358,
                height: 152,
                child: Column(
                  children: [
                    const Text("Welcome! Your Smart Travel Alarm",
                        textAlign: .center,
                        style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                    SizedBox(height: 24,),
                    const Text("Stay on schedule and enjoy every moment of your journey",
                        textAlign: .center,
                        style: TextStyle(color: Colors.white,fontSize: 15 )),
                  ],
                ),
              ),
            ),
             SizedBox(height: 30,),
            Image.asset("assets/images/image1.jpg",
            width:305 ,
            height:215 ,
            ), // Static Image as requested
            SizedBox(height: 50,),
            SizedBox(
                width: double.infinity,
                height: 76,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: BorderSide(color: Colors.white),
                      foregroundColor: Colors.white,

                    ),
                    onPressed: () => Provider.of<AlarmProvider>(context, listen: false).fetchLocation(),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Use Current Location",style: TextStyle(
                          fontSize: 25
                        ),),
                        SizedBox(width: 5,),
                        ImageIcon(
                          AssetImage("assets/images/location-05.png"),
                          color: Colors.white, // You can easily change the color here
                          size: 25,
                        )
                      ],
                    ))),
            SizedBox(height: 29,),
            SizedBox(
              width: double.infinity,
              height: 76,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.accentPurple,
                  foregroundColor: Colors.white
                ),
                  onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                  child: const Text("Home",
                  style: TextStyle(
                    fontSize: 25
                  ),)),
            ),
          ],
        ),
      ),
    );
  }
}