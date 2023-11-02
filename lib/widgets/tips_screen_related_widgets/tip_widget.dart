import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/tip_data_model.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class TipWidget extends StatelessWidget {
  const TipWidget({
    super.key,
    required this.tipModel,
    required this.onTap,
  });
  final TipModel tipModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey,
            blurRadius: 10.r,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 15.w,
                right: 15.w,
                top: 10.h
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTexts.body(
                  text: tipModel.tipTitle,
                  fontSize:
                  ScreenUtil().deviceType() == DeviceType.tablet
                      ? 20.sp
                      : 17.sp,
                  isHeadline: true,
                ),
                Image.asset(
                  'assets/icons/light-bulb.png',
                  height: 20.h,
                  width: 20.w,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),

          Container(
            height: 130.h,
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(tipModel.tipCover),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: Material(
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(12.r),
                child: Ink(
                  height: 30.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColors.primaryDark,
                  ),
                  child: Center(
                    child: AppTexts.body(
                      text: 'Show Details',
                      fontSize: 13.sp,
                      textAlign: TextAlign.center,
                      fontColor: AppColors.lightGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}