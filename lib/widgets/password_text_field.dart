import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/theme/app_colors.dart';
import '../view_controllers/password_config_cubit/password_config_cubit.dart';
import 'main_text_field.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({required this.controller,super.key});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordConfigCubit, PasswordConfigState>(
      builder: (context, password) {
        return MainTextField(
          controller: controller,
          hintText: 'password_field'.tr,
          isPassword:
          password.passwordStatus == PasswordStatus.hidden,
          suffix: Padding(
            padding: EdgeInsets.only(right: 10.w,left: 10.w),
            child: InkWell(
              onTap: () {
                context
                    .read<PasswordConfigCubit>()
                    .togglePasswordStatus();
              },
              child: Image.asset(
                password.passwordStatus == PasswordStatus.hidden
                    ? 'assets/icons/eye_closed.png'
                    : 'assets/icons/eye_opened.png',
                height: 25.h,
                color: AppColors.primaryDark,
              ),
            ),
          ),
        );
      },
    );
  }
}
