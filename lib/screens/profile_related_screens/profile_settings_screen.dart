import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/widgets/main_app_button.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_texts.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 40.h,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.primaryDark,
          ),
        ),
        title: AppTexts.body(
          text: 'Settings',
          isHeadline: true,
          fontSize: 18.sp,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          CircleAvatar(
            radius: 35.r,
            backgroundImage: AssetImage(
              'assets/icons/profile_photo.png',
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          MainAppButton(
            label: 'Edit Picture',
            height: 30.h,
            width: 100.w,
            onTap: () {},
            borderRadius: 2.r,
            backgroundColor: Colors.white,
            fontColor: Colors.blue,
            splashColor: Colors.blueAccent,

          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts.body(
                  text: 'Name',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTexts.body(
                        text: 'Sa\'ad Ghazal',
                        fontSize: 15.sp,
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 28.w,
          vertical: bottomPadding == 0 ? 20.h : bottomPadding.h,
        ),
        child: MainAppButton(
          label: 'Logout',
          height: 40.h,
          width: double.maxFinite,
          onTap: () {},
          borderRadius: 12.r,
          backgroundColor: Colors.redAccent,
          splashColor: Colors.red,
          isIconed: true,
          icon: Icon(
            Icons.logout,
            color: AppColors.lightGrey,
          ),
        ),
      ),
    );
  }
}
