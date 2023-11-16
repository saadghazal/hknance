import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hknance/view_controllers/contorllers_exports.dart';

import 'package:hknance/screens/admin_related_screens/admin_main_screen.dart';
import 'package:hknance/screens/main_screens/main_screen.dart';
import 'package:hknance/screens/on_boarding_screen.dart';
import 'package:hknance/utils/storage_service/storage_service.dart';

import '../utils/notifications_center/notifications_center.dart';
import '../utils/routing_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool? isAdmin;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAdmin = StorageService.getIsAdmin();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state)async {
        if (state.authStatus == AuthStatus.authenticated) {
          if(isAdmin == null){
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
            return;
          }
          if (isAdmin!) {
            Future.delayed(
              Duration(seconds: 2),
              () {
                Navigator.pushAndRemoveUntil(
                  context,
                  RoutingAnimation.fade(screen: AdminMainScreen()),
                  (route) => false,
                );
              },
            );
          } else {
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
          }
          return;
        } else {
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
        await NotificationsCenter.initialize();
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
