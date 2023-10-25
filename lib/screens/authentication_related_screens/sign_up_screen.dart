import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/screens/authentication_related_screens/sign_up_successfully_screen.dart';
import 'package:hknance/utils/errors/error_snack_bar.dart';
import 'package:hknance/view_controllers/sign_up_cubit/sign_up_cubit.dart';
import 'package:hknance/widgets/main_app_bar.dart';
import 'package:hknance/widgets/main_loading.dart';
import 'package:hknance/widgets/password_text_field.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../widgets/main_app_button.dart';
import '../../widgets/main_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.loadingStatus == LoadingStatus.loaded) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignUpSuccessfullyScreen()),
            (route) => false,
          );
        }
        if (state.loadingStatus == LoadingStatus.error) {
          showErrorSnackBar(
            context: context,
            errorMessage: state.errorHandler.message,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: MainAppBar(
            title: 'Sign Up',
            backIcon: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: AppColors.primaryDark,
                size: ScreenUtil().deviceType() == DeviceType.tablet
                    ? 26.sp
                    : 24.sp,
              ),
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
                      text: 'Profile Picture',
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
                        radius: 40.r,
                        child: Icon(
                          Icons.photo_camera_rounded,
                          size: 32.sp,
                        ),
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
                      controller: nameController,
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
                      controller: emailController,
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
                    PasswordTextField(controller: passwordController),
                    SizedBox(
                      height: 40.h,
                    ),
                    state.loadingStatus == LoadingStatus.loading
                        ? const MainLoading()
                        : MainAppButton(
                            label: 'SignUp',
                            height: 40.h,
                            width: double.maxFinite,
                            onTap: () async {
                              if (emailController.text.isEmpty ||
                                  passwordController.text.isEmpty ||
                                  nameController.text.isEmpty) {
                                showErrorSnackBar(
                                  context: context,
                                  errorMessage:
                                      'Please fill the missing fields',
                                );
                                return;
                              }
                              await context.read<SignUpCubit>().signUp(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                            },
                            borderRadius: 12.r,
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
