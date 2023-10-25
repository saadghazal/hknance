import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/theme/app_colors.dart';

class MainLoading extends StatelessWidget {
  const MainLoading({this.color,super.key});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: double.maxFinite,
      child: Center(
        child: Platform.isIOS
            ?  CupertinoActivityIndicator(
                color: color ?? AppColors.primaryDark,
              )
            :  CircularProgressIndicator(
                color: color ?? AppColors.primaryDark,
              ),
      ),
    );
  }
}
