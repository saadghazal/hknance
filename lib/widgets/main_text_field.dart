import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({
    required this.controller,
    required this.hintText,
     this.isPassword = false,
    this.suffix,
    this.textInputAction = TextInputAction.done,
    super.key,
  });
  final TextEditingController controller;
  final String hintText;
  final Widget? suffix;
  final bool isPassword;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.primaryDark,
      controller: controller,
      obscureText: isPassword,
      textInputAction: textInputAction,
      style: const TextStyle(
        color: AppColors.primaryDark,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.sp),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 12.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.primaryDarkGrey.withOpacity(0.5),
            width: 1.2,
          ),
        ),
        suffixIconConstraints: BoxConstraints(
          maxHeight: 50.h,
        ),
        suffixIcon: suffix,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryDarkGrey.withOpacity(0.5),
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
