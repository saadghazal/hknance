import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/view_controllers/sign_out_cubit/sign_out_cubit.dart';

import '../screens/on_boarding_screen.dart';
import '../utils/routing_animation.dart';
import '../utils/theme/app_colors.dart';
import 'main_app_button.dart';

class MainLogoutButton extends StatelessWidget {
  const MainLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  MainAppButton(
      label: 'Logout',
      height: 40.h,
      width: double.maxFinite,
      onTap: () async{
      await  context.read<SignOutCubit>().signOut();
      },
      borderRadius: 12.r,
      backgroundColor: Colors.redAccent,
      splashColor: Colors.red,
      isIconed: true,
      icon: const Icon(
        Icons.logout,
        color: AppColors.lightGrey,
      ),
    );
  }
}
