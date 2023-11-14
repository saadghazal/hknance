import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:hknance/view_controllers/contorllers_exports.dart';
import 'package:hknance/screens/admin_related_screens/admin_main_screen.dart';
import 'package:hknance/screens/main_screens/main_screen.dart';
import 'package:hknance/utils/errors/error_snack_bar.dart';

import 'package:hknance/widgets/auth_button.dart';
import 'package:hknance/widgets/go_sign_up_text.dart';
import 'package:hknance/widgets/main_app_bar.dart';

import 'package:hknance/widgets/main_loading.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../widgets/password_text_field.dart';
import '../../widgets/text_field_section.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({required this.isAdmin, super.key});

  final bool isAdmin;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    print('Disposed');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.loadingStatus == LoadingStatus.error) {
          showErrorSnackBar(
            context: context,
            errorMessage: state.errorHandler.message,
          );
        }
        if (state.loadingStatus == LoadingStatus.loaded) {
          if (widget.isAdmin) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const AdminMainScreen(),
              ),
              (route) => false,
            );
          } else {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ),
              (route) => false,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: MainAppBar(
            title: 'login'.tr,
            backIcon: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.primaryDark,
                size: ScreenUtil().deviceType() == DeviceType.tablet
                    ? 26.sp
                    : 24.sp,
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
                    text: 'welcome_back'.tr,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  AppTexts.body(
                    text: !widget.isAdmin
                        ? 'welcome_desc_user'.tr
                        : 'welcome_desc_admin'.tr,
                    fontSize: 14.sp,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  TextFieldSection(
                    controller: emailController,
                    title: 'email'.tr,
                    hintText: 'email_field'.tr,
                    isLastField: false,
                    icon: Padding(
                      padding: EdgeInsets.only(right: 10.w,left: 10.w),
                      child: Image.asset(
                        'assets/icons/mail.png',
                        height: 25.h,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                  AppTexts.body(
                    text: 'password'.tr,
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
                      ? MainLoading()
                      : AuthButton(
                          label: 'login'.tr,
                          onTap: () async {
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              showErrorSnackBar(
                                context: context,
                                errorMessage: 'Please fill the missing fields',
                              );
                              return;
                            }
                            await context.read<SignInCubit>().signIn(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  isAdmin: widget.isAdmin,
                                );
                          },
                        ),
                  signUp(isAdmin: !widget.isAdmin),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget signUp({required bool isAdmin}) {
  return Visibility(
    visible: isAdmin,
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
        GoSignUp(),
      ],
    ),
  );
}
