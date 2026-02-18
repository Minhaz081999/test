import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OnboardingVideo extends StatefulWidget {
  final String videoPath;
  const OnboardingVideo({required this.videoPath, super.key});

  @override
  State<OnboardingVideo> createState() => _OnboardingVideoState();
}

class _OnboardingVideoState extends State<OnboardingVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Critical for performance
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
    )
        : const Center(child: CircularProgressIndicator());
  }
}