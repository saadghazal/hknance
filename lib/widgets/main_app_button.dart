import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../utils/theme/app_colors.dart';
import '../utils/theme/app_texts.dart';

class MainAppButton extends StatelessWidget {
  const MainAppButton({
    required this.label,
    required this.height,
    required this.width,
    required this.onTap,
    required this.borderRadius,
    this.splashColor,
    this.backgroundColor,
    this.borderColor,
    this.fontColor,
    this.isIconed = false,
    this.fontSize,
    this.icon,
    super.key,
  });
  final String label;
  final double width;
  final double height;
  final bool isIconed;
  final Widget? icon;
  final double? fontSize;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? fontColor;
  final Color? borderColor;
  final VoidCallback onTap;
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        focusColor: splashColor ?? AppColors.primaryYellow,
        splashColor: splashColor?.withOpacity(0.5) ?? AppColors.primaryDarkGrey,
        highlightColor:
            splashColor?.withOpacity(0.5) ?? AppColors.primaryDarkGrey,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor ?? AppColors.primaryDark,
            border: borderColor != null
                ? Border.all(
                    color: borderColor!,
                  )
                : null,
          ),
          child: isIconed
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTexts.body(
                      text: label,
                      fontSize: 13.sp,
                      textAlign: TextAlign.center,
                      fontColor: fontColor ?? AppColors.lightGrey,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                    icon!
                  ],
                )
              : Center(
                  child: AppTexts.body(
                    text: label,
                    fontSize: fontSize == null
                        ? ScreenUtil().deviceType() == DeviceType.tablet
                            ? 15.sp
                            : 13.sp
                        : fontSize!,
                    textAlign: TextAlign.center,
                    fontColor: fontColor ?? AppColors.lightGrey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ),
    );
  }
}
