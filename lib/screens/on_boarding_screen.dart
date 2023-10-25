import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hknance/widgets/on_boarding_button.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).viewPadding.top;
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.only(
            top: topPadding == 0 ? 20.h : topPadding.h,
            bottom: bottomPadding == 0 ? 20.h : bottomPadding.h,
            left: 20.w,
            right: 20.w,
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/logo/hknance_logo.jpg',
                height: 100.h,
                width: 100.w,
                fit: BoxFit.cover,
              ),
              const Spacer(),
              const OnBoardingButton(isAdmin: false),
              SizedBox(
                height: 10.h,
              ),
              const OnBoardingButton(isAdmin: true)
            ],
          ),
        ),
      ),
    );
  }
}
