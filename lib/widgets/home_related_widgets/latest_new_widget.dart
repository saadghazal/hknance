import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/new_data_model.dart';
import 'package:intl/intl.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class LatestNewWidget extends StatelessWidget {
  const LatestNewWidget({required this.onTap,required this.newModel,super.key,});
  final NewModel newModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.lightGrey,
                blurRadius: 10.r,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r)),
                  image:  DecorationImage(
                    image: NetworkImage(newModel.newCover),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: AppTexts.body(
                  text: newModel.newTitle,
                  fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                      ? 20.sp
                      : 18.sp,
                  isHeadline: true,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 10.w),
              //   child: AppTexts.body(
              //     text: 'Description',
              //     fontSize: ScreenUtil().deviceType() == DeviceType.tablet
              //         ? 16.sp
              //         : 14.sp,
              //     fontColor: AppColors.primaryDarkGrey.withOpacity(0.5),
              //   ),
              // ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: AppTexts.body(
                  text: '${DateFormat.yMMMMEEEEd().format(newModel.createdAt).split(',')[0]}, ${DateFormat.yMd().format(newModel.createdAt)}, ${DateFormat.jm().format(newModel.createdAt)}',
                  fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                      ? 15.sp
                      : 12.sp,
                  fontColor: AppColors.primaryDarkGrey.withOpacity(0.5),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
