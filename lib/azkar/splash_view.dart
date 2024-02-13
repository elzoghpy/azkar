import 'dart:async';

import 'package:azkar_notification/constants/app_striengs.dart';
import 'package:azkar_notification/constants/assets.dart';
import 'package:flutter/material.dart';

import '../constants/timer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  startDelay() {
    timer = Timer(const Duration(seconds: AppTimer.splashDelay), goNext);
  }

  goNext() async {
    Navigator.pushReplacementNamed(context, home);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(
            Assets.images14,
            // ImageAssets.splash0Image,
          ),
          fit: BoxFit.cover,
          height: double.infinity,
        ),
      ),
    );
  }
}
