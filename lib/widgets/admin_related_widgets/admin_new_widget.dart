import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../screens/admin_related_screens/add_new_screen.dart';
import '../../utils/routing_animation.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class AdminNewWidget extends StatelessWidget {
  const AdminNewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      //
      width: double.maxFinite,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey.withOpacity(0.5),
            blurRadius: 10.r,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 45.w,
            height: 45.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/icons/news_cover.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts.body(
                  text: 'New Title',
                  fontSize: 14.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 5.h,
                ),
                AppTexts.body(
                  text:
                  '${DateFormat.yMMMMEEEEd().format(DateTime.now()).split(',')[0]}, ${DateFormat.yMd().format(DateTime.now())}',
                  fontSize: 12.sp,
                  fontColor: AppColors.primaryDarkGrey,
                ),
              ],
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                RoutingAnimation.downToUp(
                  screen: const AddNewScreen(
                    isEditing: true,
                    title: 'New Title',
                    newCover: 'assets/icons/news_cover.jpg',
                    newBody:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                  ),
                ),
              );
            },
            child: Icon(
              Icons.edit,
              color: AppColors.primaryDark,
              size: ScreenUtil().deviceType() == DeviceType.tablet ? 24.sp : 22.sp,
            ),
          ),
        ],
      ),
    );
  }
}
