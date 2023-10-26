import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hknance/screens/main_screens/main_screen.dart';
import 'package:hknance/screens/on_boarding_screen.dart';
import 'package:hknance/view_controllers/auth_bloc/auth_bloc.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.authenticated) {
          Future.delayed(
            Duration(seconds: 2),
            () {
              Navigator.pushAndRemoveUntil(
                context,
                RoutingAnimation.fade(screen: MainScreen()),
                (route) => false,
              );
            },
          );
          return;
        }else {
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

      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/logo/hknance_logo.jpg',
            height: height * 0.22,
          ),
        ),
      ),
    );
  }
}
