import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_texts.dart';

void showErrorSnackBar({
  required BuildContext context,
  required String errorMessage,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: AppTexts.body(
        text: errorMessage,
        fontSize: 14.sp,
        fontColor: AppColors.lightGrey,
        overflow: TextOverflow.clip,
        isHeadline: true,
      ),
      backgroundColor: Colors.redAccent,
    ),
  );
}
