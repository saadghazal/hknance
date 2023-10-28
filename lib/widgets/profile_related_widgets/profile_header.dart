import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/user_data_model.dart';
import 'package:hknance/view_controllers/user_bloc/user_bloc.dart';

import '../../repositories/auth_repository.dart';
import '../../screens/profile_related_screens/profile_settings_screen.dart';
import '../../utils/routing_animation.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../view_controllers/sign_out_cubit/sign_out_cubit.dart';
import '../main_app_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.userModel,
    required this.postsNumber,
    super.key,
  });
  final int postsNumber;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 15.h,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32.r,
                backgroundColor: AppColors.primaryDark,
                backgroundImage: userModel.profilePicture.isNotEmpty
                    ? NetworkImage(
                        userModel.profilePicture,
                      )
                    : AssetImage('assets/icons/profile-icon-9.png')
                        as ImageProvider,
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTexts.body(
                    text: userModel.name,
                    fontColor: AppColors.primaryDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  AppTexts.body(
                    text: userModel.email,
                    fontColor: AppColors.primaryDark,
                    fontSize: 14.sp,
                  ),
                ],
              ),
              const Spacer(),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      AppTexts.body(
                        text: 'Posts',
                        fontSize: 15.sp,
                        fontColor: AppColors.primaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppTexts.body(
                        text: postsNumber.toString(),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Expanded(
                child: MainAppButton(
                  label: 'Profile Settings',
                  height: 40.h,
                  width: double.maxFinite,
                  onTap: () {
                    Navigator.of(context).push(
                      RoutingAnimation.downToUp(
                        screen: MultiBlocProvider(
                          providers: [
                            BlocProvider<SignOutCubit>(
                              create: (context) => SignOutCubit(
                                  authRepository:
                                      context.read<AuthRepository>()),
                            ),
                            BlocProvider.value(
                              value: context.read<UserBloc>(),
                            )
                          ],
                          child: ProfileSettingsScreen(),
                        ),
                      ),
                    );
                  },
                  borderRadius: 10.r,
                  borderColor: AppColors.primaryDark,
                  backgroundColor: Colors.transparent,
                  fontColor: AppColors.primaryDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
