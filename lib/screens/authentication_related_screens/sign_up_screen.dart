import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hknance/view_controllers/contorllers_exports.dart';
import 'package:hknance/screens/authentication_related_screens/sign_up_successfully_screen.dart';
import 'package:hknance/utils/errors/error_snack_bar.dart';

import 'package:hknance/widgets/auth_button.dart';
import 'package:hknance/widgets/main_app_bar.dart';
import 'package:hknance/widgets/main_loading.dart';
import 'package:hknance/widgets/password_text_field.dart';
import 'package:hknance/widgets/text_field_section.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

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
            title: 'sign_up'.tr,
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
                child: BlocConsumer<ImagePickerCubit, ImagePickerState>(
                  listener: (context, imageState) {
                    if (imageState.imageStatus == ImageStatus.error) {
                      showErrorSnackBar(
                        context: context,
                        errorMessage: 'Please allow access to your photos',
                      );
                    }
                  },
                  builder: (context, imageState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        AppTexts.title2(
                          text: 'create_account'.tr,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        AppTexts.body(
                          text:
                              'create_account_desc'.tr,
                          fontSize: 14.sp,
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        AppTexts.body(
                          text: 'profile_pic'.tr,
                          fontSize: 15.sp,
                          fontColor: AppColors.primaryDark,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        imageState.imageStatus == ImageStatus.picked
                            ? Center(
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 40.r,
                                      backgroundImage:
                                          FileImage(imageState.imageFile),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () async {
                                          await context
                                              .read<ImagePickerCubit>()
                                              .pickImage();
                                        },
                                        borderRadius:
                                            BorderRadius.circular(50.r),
                                        child: CircleAvatar(
                                          radius: 15.r,
                                          backgroundColor:
                                              AppColors.primaryDark,
                                          child: Icon(
                                            Icons.edit,
                                            size: 18.sp,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Center(
                                child: InkWell(
                                  onTap: () async {
                                    await context
                                        .read<ImagePickerCubit>()
                                        .pickImage();
                                  },
                                  borderRadius: BorderRadius.circular(50.r),
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.primaryDark,
                                    radius: 40.r,
                                    child: Icon(
                                      Icons.photo_camera_rounded,
                                      size: 32.sp,
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 15.h,
                        ),
                        TextFieldSection(
                          controller: nameController,
                          title: 'name'.tr,
                          hintText: 'name_field'.tr,
                          isLastField: false,
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
                            ? const MainLoading()
                            : AuthButton(
                                label: 'sign_up'.tr,
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
                                        pictureFile: imageState.imageFile,
                                      );
                                },
                              ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
