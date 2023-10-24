import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme/app_colors.dart';

class FloatingAddButton extends StatelessWidget {
  const FloatingAddButton({
    required this.onTap,
    super.key,
  });
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50.r),
      child: Ink(
        height: 50.h,
        width: 50.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryDark,
        ),
        child:  Icon(
          Icons.add,
          color: AppColors.primaryYellow,
          size: ScreenUtil().deviceType() == DeviceType.tablet ? 26.sp : 24.sp,
        ),
      ),
    );
  }
}
