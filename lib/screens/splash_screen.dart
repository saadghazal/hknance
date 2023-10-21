import 'package:flutter/material.dart';
import 'package:hknance/screens/on_boarding_screen.dart';

import '../utils/routing_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(
      Duration(seconds: 2),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          RoutingAnimation.fade(screen: OnBoardingScreen()),
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo/hknance_logo.jpg',
          height: height * 0.22,
        ),
      ),
    );
  }
}
