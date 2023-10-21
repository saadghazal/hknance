import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/screens/authentication_related_screens/sign_up_screen.dart';
import 'package:hknance/screens/main_screens/main_screen.dart';
import 'package:hknance/theme/app_colors.dart';
import 'package:hknance/theme/app_texts.dart';
import 'package:hknance/widgets/main_app_button.dart';
import 'package:hknance/widgets/main_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({required this.isAdmin, super.key});
  final bool isAdmin;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (
        context,
        primary,
        secondary,
      ) {
        return const SignUpScreen();
      },
      transitionsBuilder: (context, primary, secondary, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = primary.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
    );
  }

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
            Icons.arrow_back_ios_rounded,
            color: AppColors.primaryDark,
          ),
        ),
        title: AppTexts.body(
          text: 'Login',
          isHeadline: true,
          fontSize: 18.sp,
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
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                    (route) => false,
                  );
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
                                  Navigator.of(context).push(_createRoute());
                                },
                            ),
                            TextSpan(
                              text: 'Sign Up!',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(_createRoute());
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
