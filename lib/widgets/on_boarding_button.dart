import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:hknance/view_controllers/contorllers_exports.dart';

import '../repositories/auth_repository.dart';
import '../screens/authentication_related_screens/login_screen.dart';
import '../utils/theme/app_colors.dart';

import 'main_app_button.dart';

class OnBoardingButton extends StatelessWidget {
  const OnBoardingButton({required this.isAdmin, super.key});

  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return MainAppButton(
      label: isAdmin ? 'admin'.tr : 'user'.tr,
      height: 50.h,
      width: ScreenUtil().deviceType() == DeviceType.tablet
          ? 300.w
          : double.maxFinite,
      onTap: () {
        openLoginScreen(context, isAdmin);
      },
      fontSize: ScreenUtil().deviceType() == DeviceType.tablet ? 18.sp : 16.sp,
      borderRadius: 12.r,
      borderColor: isAdmin ? AppColors.primaryDark : null,
      fontColor: AppColors.primaryDark,
      backgroundColor: isAdmin ? Colors.transparent : AppColors.primaryYellow,
      splashColor: isAdmin ? null : Colors.white,
    );
  }
}

void openLoginScreen(BuildContext context, bool isAdmin) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignInCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<PasswordConfigCubit>(
            create: (context) => PasswordConfigCubit(),
          ),
        ],
        child: LoginScreen(
          isAdmin: isAdmin,
        ),
      ),
    ),
  );
}
