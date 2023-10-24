import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class AddCoverWidget extends StatelessWidget {
  const AddCoverWidget({required this.tipCover, super.key});
  final String tipCover;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryDarkGrey.withOpacity(0.2),
          width: 0.5.w,
        ),
        borderRadius: BorderRadius.circular(12.r),
        image: tipCover.isNotEmpty
            ? DecorationImage(
                image: AssetImage(tipCover),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: tipCover.isNotEmpty
          ? Padding(
              padding: EdgeInsets.only(right: 5.w, top: 5.h),
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 12.r,
                  backgroundColor: AppColors.lightGrey,
                  child: Icon(
                    Icons.close,
                    color: AppColors.primaryDark,
                    size: 16.sp,
                  ),
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/gallery.png',
                  height: 50.h,
                  width: 50.w,
                  fit: BoxFit.cover,
                  color: AppColors.primaryDarkGrey.withOpacity(0.6),
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppTexts.body(
                  text: 'Add Cover',
                  fontSize: 14.sp,
                  isHeadline: true,
                  fontColor: AppColors.primaryDarkGrey.withOpacity(0.6),
                ),
              ],
            ),
    );
  }
}
