import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/user_data_model.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.userModel,super.key});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 15.h,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32.r,
            backgroundColor: AppColors.primaryDark,
            backgroundImage:userModel.profilePicture.isNotEmpty?  NetworkImage(
              userModel.profilePicture,
            ): AssetImage('assets/icons/profile-icon-9.png') as ImageProvider,
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTexts.body(
                text: userModel.name,
                fontColor: AppColors.primaryDark,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
              SizedBox(
                height: 5.h,
              ),
              AppTexts.body(
                text: userModel.email,
                fontColor: AppColors.primaryDark,
                fontSize: 14.sp,
              ),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  AppTexts.body(
                    text: 'Posts',
                    fontSize: 15.sp,
                    fontColor: AppColors.primaryDark,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  AppTexts.body(
                    text: '3',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
