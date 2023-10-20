import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTexts {
  static Text largeTitle(
      {required String text,
      FontWeight fontWeight = FontWeight.w400,
      Color fontColor = Colors.black,
      TextAlign textAlign = TextAlign.start,}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize:
            ScreenUtil().deviceType() == DeviceType.tablet ? 34.sp : 32.sp,
        fontWeight: fontWeight,
        color: fontColor,
      ),
    );
  }

  static Text title1(
      {required String text,
      FontWeight fontWeight = FontWeight.w400,
      Color fontColor = Colors.black,
      TextAlign textAlign = TextAlign.start}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize:
            ScreenUtil().deviceType() == DeviceType.tablet ? 28.sp : 26.sp,
        fontWeight: fontWeight,
        color: fontColor,
      ),
    );
  }

  static Text title2({
    required String text,
    FontWeight fontWeight = FontWeight.w400,
    Color fontColor = Colors.black,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize:
            ScreenUtil().deviceType() == DeviceType.tablet ? 24.sp : 22.sp,
        fontWeight: fontWeight,
        color: fontColor,
      ),
    );
  }

  static Text title3(
      {required String text,
      FontWeight fontWeight = FontWeight.w400,
      Color fontColor = Colors.black,
      TextAlign textAlign = TextAlign.start}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize:
            ScreenUtil().deviceType() == DeviceType.tablet ? 22.sp : 20.sp,
        fontWeight: fontWeight,
        color: fontColor,
      ),
    );
  }

  static Text body({
    required String text,
    bool isHeadline = false,
    Color fontColor = Colors.black,
    required double fontSize,
    FontWeight fontWeight = FontWeight.w400,
    TextAlign textAlign = TextAlign.start,
    TextOverflow overflow = TextOverflow.ellipsis
  }) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isHeadline ? FontWeight.w600 : fontWeight,
        color: fontColor,
      ),
    );
  }
}
