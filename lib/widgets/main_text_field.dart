import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/theme/app_colors.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.suffix,
    this.textInputAction = TextInputAction.done,
    this.isMultiline = false,
    this.isReadOnly = false,
    this.textInputType = TextInputType.text,
    this.onChanged,
    this.autoFocus = false,
    super.key,
  });
  final TextEditingController controller;
  final String hintText;
  final Widget? suffix;
  final bool isPassword;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool isMultiline;
  final bool isReadOnly;
  final bool autoFocus;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.primaryDark,
      controller: controller,
      obscureText: isPassword,
      textInputAction: textInputAction,
      maxLines: isMultiline ? null : 1,
      keyboardType: textInputType,
      readOnly: isReadOnly,
      onChanged: onChanged,
      autofocus: autoFocus,
      style: const TextStyle(
        color: AppColors.primaryDark,
      ),
      decoration: InputDecoration(
        hintText: hintText,

        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.primaryDarkGrey.withOpacity(0.5),
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 12.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.primaryDarkGrey.withOpacity(0.2),
            width: 1.2,
          ),
        ),
        suffixIconConstraints: BoxConstraints(
          maxHeight: 50.h,
        ),
        suffixIcon: suffix,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.primaryDarkGrey.withOpacity(0.2),
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
