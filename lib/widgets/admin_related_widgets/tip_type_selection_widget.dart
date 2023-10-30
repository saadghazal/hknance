import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class TipTypeSelectionWidget extends StatelessWidget {
  const TipTypeSelectionWidget({
    required this.icon,
    required this.label,
     this.onTap,
    required this.isSelected,
    super.key,
  });
  final VoidCallback? onTap;
  final String label;
  final String icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Ink(
        height: 45.h,
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.primaryDarkGrey.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 20.h,
              width: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isSelected ? AppColors.primaryYellow : Colors.transparent,
                border: isSelected
                    ? null
                    : Border.all(
                        color: AppColors.primaryDarkGrey.withOpacity(0.2),
                      ),
              ),
              child: isSelected
                  ? Center(
                      child: Icon(
                        Icons.done,
                        color: AppColors.primaryDark,
                        size: 16.sp,
                      ),
                    )
                  : SizedBox(),
            ),
            SizedBox(
              width: 10.w,
            ),
            AppTexts.body(
              text: label,
              fontSize: 14.sp,
              isHeadline: true,
            ),
            Spacer(),
            Image.asset(
              icon,
              width: 30.w,
              color:
                  isSelected ? AppColors.primaryYellow : AppColors.primaryDark,
              height: 23.h,
            ),
          ],
        ),
      ),
    );
  }
}
