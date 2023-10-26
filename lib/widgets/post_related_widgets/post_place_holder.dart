import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme/app_colors.dart';

class PostPlaceHolder extends StatelessWidget {
  const PostPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withOpacity(0.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: AppColors.primaryDarkGrey.withOpacity(0.4),
              ),
              SizedBox(
                width: 7.w,
              ),
              Container(
                width: 100.w,
                height: 20.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: AppColors.primaryDarkGrey.withOpacity(0.4),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.more_horiz_rounded,
                color: AppColors.primaryDark,
                size: ScreenUtil().deviceType() == DeviceType.tablet
                    ? 22.sp
                    : 20.sp,
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            height: 100.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: AppColors.primaryDarkGrey.withOpacity(0.4),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          const Divider(),
          Container(
            height: 30.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: AppColors.primaryDarkGrey.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
