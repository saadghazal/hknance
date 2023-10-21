import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/theme/app_colors.dart';
import '../utils/theme/app_texts.dart';


class NavBarWidget extends StatelessWidget {
  const NavBarWidget({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });
  final Function(int) onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return Container(
      height: 90.h,
      width: double.maxFinite,

      padding: EdgeInsets.only(
        left: ScreenUtil().deviceType() == DeviceType.tablet ? 30.w : 30.w,
        right: ScreenUtil().deviceType() == DeviceType.tablet ? 30.w : 30.w,
        bottom: bottomPadding == 0 ? 20.h : bottomPadding.h,
        top: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
        color: AppColors.primaryDark,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDarkGrey.withOpacity(0.2),
            blurRadius: 10.r,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navBarItem(
            condition: currentIndex == 0,
            onTap: () => onTap(0),
            icon: 'assets/icons/home_icon.png',
            label: 'Home',
          ),
          navBarItem(
            condition: currentIndex == 1,
            onTap: () => onTap(1),
            icon: 'assets/icons/light-bulb.png',
            label: 'Tips',
          ),
          navBarItem(
            condition: currentIndex == 2,
            onTap: () => onTap(2),
            icon: 'assets/icons/globe.png',
            label: 'Community',
          ),
          navBarItem(
            condition: currentIndex == 3,
            onTap: () => onTap(3),
            icon: 'assets/icons/user.png',
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

Widget navBarItem({
  required bool condition,
  required VoidCallback onTap,
  required String icon,
  required String label,
}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedSize(
      duration: Duration(milliseconds: 200),
      reverseDuration: Duration(milliseconds: 200),
      child: Visibility(
        visible: condition,
        replacement: Image.asset(
          icon,
          color: AppColors.lightGrey,
          height: 20.h,
          width: 20.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              color: AppColors.primaryYellow,
              height: 24.h,
              width: 24.w,
            ),
            AppTexts.body(
              text: label,
              fontSize: 12.sp,
              fontColor: AppColors.primaryYellow,
              isHeadline: true,
            ),
          ],
        ),
      ),
    ),
  );
}
