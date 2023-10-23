import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/screens/admin_related_screens/admin_main_screen.dart';
import 'package:hknance/screens/authentication_related_screens/sign_up_screen.dart';
import 'package:hknance/screens/main_screens/main_screen.dart';
import 'package:hknance/utils/routing_animation.dart';
import 'package:hknance/widgets/main_app_bar.dart';

import 'package:hknance/widgets/main_app_button.dart';
import 'package:hknance/widgets/main_text_field.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({required this.isAdmin, super.key});
  final bool isAdmin;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Login',
        backIcon: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.primaryDark,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              AppTexts.title2(
                text: 'Welcome Back!',
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 5.h,
              ),
              AppTexts.body(
                text: !widget.isAdmin
                    ? 'Please enter your info to get the latest\ntips and news about trading!'
                    : 'Please login to provide users\nwith the latest trading news and tips',
                fontSize: 14.sp,
              ),
              SizedBox(
                height: 40.h,
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
                label: 'Login',
                height: 40.h,
                width: double.maxFinite,
                onTap: () {
                  if(widget.isAdmin){
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => AdminMainScreen(),
                      ),
                          (route) => false,
                    );
                  }else {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ),
                          (route) => false,
                    );
                  }

                },
                borderRadius: 12.r,
              ),
              Visibility(
                visible: !widget.isAdmin,
                replacement: SizedBox(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    const Divider(),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Open Sans',
                            color: AppColors.primaryDark,
                          ),
                          children: [
                            TextSpan(
                              text: 'Don\'t have an account? ',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(
                                    RoutingAnimation.downToUp(
                                      screen: SignUpScreen(),
                                    ),
                                  );
                                },
                            ),
                            TextSpan(
                              text: 'Sign Up!',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(
                                    RoutingAnimation.downToUp(
                                      screen: SignUpScreen(),
                                    ),
                                  );
                                },
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
