import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/utils/theme/app_colors.dart';
import 'package:hknance/utils/theme/app_texts.dart';

import '../widgets/main_app_button.dart';

void showConfirmDialog({
  required BuildContext context,
  required VoidCallback onDelete,
  required String title,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTexts.title3(
              text:title,
              textAlign: TextAlign.center,
              fontColor: Colors.redAccent,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 10.h,
            ),
            AppTexts.body(
              text: 'Are you sure?',
              fontSize: 16.sp,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.h,
            ),
            MainAppButton(
              label: 'Delete',
              height: 35.h,
              width: double.maxFinite,
              fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                  ? 18.sp
                  : 16.sp,
              onTap: onDelete,
              borderRadius: 12.r,
              backgroundColor: Colors.redAccent,
              splashColor: Colors.red,
            ),
            SizedBox(
              height: 5.h,
            ),
            MainAppButton(
              label: 'Cancel',
              height: 35.h,
              width: double.maxFinite,
              fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                  ? 18.sp
                  : 16.sp,
              onTap: () async {
                Navigator.pop(context);
              },
              borderRadius: 12.r,
              fontColor: AppColors.primaryDark,
              backgroundColor: Colors.transparent,
              splashColor: AppColors.lightGrey,
            ),
          ],
        ),
      ),
    ),
  );
}
