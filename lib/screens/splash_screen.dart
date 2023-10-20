import 'package:flutter/material.dart';
import 'package:hknance/screens/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200)
    );
    animation = Tween<double>(begin: 0.2, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    Future.delayed(
      Duration(seconds: 2),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, primary, secondary) {
              return OnBoardingScreen();
            },
            transitionsBuilder:
                (context, primaryAnimation, secondaryAnimation, child) {
              animationController.forward();
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
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
