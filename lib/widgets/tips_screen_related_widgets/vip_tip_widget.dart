import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/tip_data_model.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class VipTipWidget extends StatelessWidget {
  const VipTipWidget({required this.tipModel,super.key});
  final TipModel tipModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(
        horizontal:
        ScreenUtil().deviceType() == DeviceType.tablet ? 32.w : 16.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image:  DecorationImage(
          image: NetworkImage(tipModel.tipCover),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withOpacity(0.2),
            blurRadius: 10.r,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height:
          ScreenUtil().deviceType() == DeviceType.tablet ? 50.h : 40.h,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: AppTexts.body(
            text: tipModel.tipTitle,
            fontColor: AppColors.primaryDark,
            fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                ? 20.sp
                : 17.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
