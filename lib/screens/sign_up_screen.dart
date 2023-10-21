import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_texts.dart';
import '../widgets/main_app_button.dart';
import '../widgets/main_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Icons.close,
            color: AppColors.primaryDark,
          ),
        ),
        title: AppTexts.body(
          text: 'Sign Up',
          isHeadline: true,
          fontSize: 18.sp,
        ),
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                AppTexts.title2(
                  text: 'Create Account',
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: 5.h,
                ),
                AppTexts.body(
                  text:
                  'Create account to get latest\ntrading tips and news',
                  fontSize: 14.sp,
                ),
                SizedBox(
                  height: 40.h,
                ),
                AppTexts.body(
                  text: 'Upload Profile Picture',
                  fontSize: 15.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: CircleAvatar(
                    backgroundColor: AppColors.primaryDark,
                    radius: 45.r,
                    child: Icon(Icons.photo_camera_rounded,size: 32.sp,),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                AppTexts.body(
                  text: 'Name',
                  fontSize: 15.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                MainTextField(
                  controller: TextEditingController(),
                  hintText: 'Enter your name',
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppTexts.body(
                  text: 'Email',
                  fontSize: 15.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                MainTextField(
                  controller: TextEditingController(),
                  hintText: 'Enter your email',
                  textInputAction: TextInputAction.next,

                  suffix: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Image.asset(
                      'assets/icons/mail.png',
                      height: 25.h,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppTexts.body(
                  text: 'Password',
                  fontSize: 15.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                MainTextField(
                  controller: TextEditingController(),
                  hintText: 'Enter your password',
                  suffix: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Image.asset(
                      'assets/icons/eye_closed.png',
                      height: 25.h,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                MainAppButton(
                  label: 'SignUp',
                  height: 40.h,
                  width: double.maxFinite,
                  onTap: () {},
                  borderRadius: 12.r,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
