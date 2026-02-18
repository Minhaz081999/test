import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../constants/app_colors.dart';
import '../common_widgets/video_player_widget.dart';
import 'alarm_provider.dart';

// --- ONBOARDING ---
class OnboardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  final List<Map<String, String>> data = [
    {"t": "Discover the world, one journey at a time.", "d": "From hidden gems to iconic destinations, we make travel simple, inspiring, and unforgettable.your next adventure today.", "v": "assets/videos/video1.mp4"},
    {"t": "Explore horizonsExplore new horizons, one step at a time.", "d": "Every trip holds a story waiting to be lived. Let us guide you to experiences that inspire, connect, and last a lifetime.", "v": "assets/videos/video2.mp4"},
    {"t": "See the beauty, one journey at a time.", "d": "Travel made simple and exciting-discover places you'll love and moments you'll never forget.", "v": "assets/videos/video3.mp4"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: data.length,
            itemBuilder: (context, i) => Column
              (
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment :Alignment.topCenter ,
                  child: Container(

                      width: double.infinity,
                      height: 429,
                      child: OnboardingVideo(videoPath: data[i]['v']!)),
                ), // Your mp4 videos
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    child: Column(
                      children: [
                        Text(data[i]['t']!, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 20,),
                        Text(data[i]['d']!, textAlign: TextAlign.start, style: const TextStyle(color: Colors.white70)),

                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                // 3. THE THREE DOTS (Page Indicator)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(data.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 8),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        // these are Dots shape
                        shape: BoxShape.circle,
                        // Active dot is Purple, inactive dots are Grey
                        color: _pageController.page?.round() == index
                            ? AppColors.accentPurple
                            : Colors.white24,
                      ),
                    );
                  }),
                ),
                //Text(data[i]['d']!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 30),
                SizedBox(
                  width: 360,
                  height: 76,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentPurple,
                    ),
                    onPressed: () => i == 2 ? Navigator.pushReplacementNamed(context, '/location') : _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      child: const Text("Next",style: TextStyle(
                        fontSize: 25,
                        color: Colors.white
                      ),),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(top: 50, right: 20, child: TextButton(onPressed: () => Navigator.pushReplacementNamed(context, '/location'), child: const Text("Skip", style: TextStyle(color: Colors.white)))),
        ],
      ),
    );
  }
}

