import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/screens/main_screens/main_screen.dart';
import 'package:hknance/widgets/main_app_button.dart';
import 'package:lottie/lottie.dart';

import '../../utils/theme/app_texts.dart';

class SignUpSuccessfullyScreen extends StatelessWidget {
  const SignUpSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/icons/done_order.json',
              height: 150.h,
              width: 150.w,
              fit: BoxFit.cover,
              repeat: false,
            ),
            SizedBox(
              height: 20.h,
            ),
            AppTexts.title2(
              text: 'Signed Up Successfully!',
            ),
            SizedBox(
              height: 20.h,
            ),
            MainAppButton(
              label: 'Done',
              height: 40.h,
              width: 100.w,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  (route) => false,
                );
              },
              borderRadius: 12.r,
              backgroundColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
