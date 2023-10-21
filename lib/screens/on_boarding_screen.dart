import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/screens/authentication_related_screens/login_screen.dart';
import 'package:hknance/theme/app_colors.dart';
import 'package:hknance/widgets/main_app_button.dart';

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
              Spacer(),
              MainAppButton(
                label: 'User',
                height: ScreenUtil().deviceType() == DeviceType.tablet
                    ? 80.h
                    : 50.h,
                width: ScreenUtil().deviceType() == DeviceType.tablet
                    ? 200.w
                    : double.maxFinite,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        isAdmin: false,
                      ),
                    ),
                  );
                },
                fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                    ? 18.sp
                    : 16.sp,
                borderRadius: 12.r,
                backgroundColor: AppColors.primaryYellow,
                fontColor: AppColors.primaryDark,
                splashColor: Colors.white,
              ),
              SizedBox(
                height: 10.h,
              ),
              MainAppButton(
                label: 'Admin',
                height: ScreenUtil().deviceType() == DeviceType.tablet
                    ? 80.h
                    : 50.h,
                width: ScreenUtil().deviceType() == DeviceType.tablet
                    ? 200.w
                    : double.maxFinite,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(
                        isAdmin: true,
                      ),
                    ),
                  );
                },
                fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                    ? 18.sp
                    : 16.sp,
                borderRadius: 12.r,
                borderColor: AppColors.primaryDark,
                fontColor: AppColors.primaryDark,
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
