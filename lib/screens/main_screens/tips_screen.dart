import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/widgets/tips_screen_related_widgets/vip_tips_list.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../widgets/tips_screen_related_widgets/user_tips_list.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/logo/hknance_logo.jpg',
          height: 70.h,
        ),
        centerTitle: true,
        toolbarHeight:
        ScreenUtil().deviceType() == DeviceType.tablet ? 70.h : 40.h,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppTexts.title2(
                text: 'Vip Tips',
                fontWeight: FontWeight.w600,
                fontColor: AppColors.primaryDark,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(height: 150.h,child: VipTipList()),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppTexts.title2(
                text: 'Daily Tips',
                fontWeight: FontWeight.w600,
                fontColor: AppColors.primaryDark,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            UserTipsList(),
          ],
        ),
      ),
    );
  }
}

// AppBar(
// backgroundColor: AppColors.primaryYellow,
// toolbarHeight: 100.h,
// elevation: 0,
// centerTitle: true,
// title: Column(
// children: [
// AppTexts.body(
// text:
// 'Subscribe with us now to get the VIP tips\n Only For 0.45 JOD!',
// fontSize: 15.sp,
// textAlign: TextAlign.center,
// fontWeight: FontWeight.w700,
// ),
// SizedBox(
// height: 5.h,
// ),
// InkWell(
// onTap: () {},
// borderRadius: BorderRadius.circular(12.r),
// child: Ink(
// height: 40.h,
// width: 180.w,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(20.r),
// color: AppColors.primaryDark,
// ),
// child: Center(
// child: AppTexts.body(
// text: 'Subscribe Now',
// fontSize: 13.sp,
// textAlign: TextAlign.center,
// fontColor: AppColors.lightGrey,
// fontWeight: FontWeight.w600,
// ),
// ),
// ),
// ),
// ],
// ),
// )