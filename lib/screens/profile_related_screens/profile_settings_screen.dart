import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hknance/view_controllers/contorllers_exports.dart';
import 'package:hknance/utils/errors/error_snack_bar.dart';
import 'package:hknance/widgets/main_app_bar.dart';
import 'package:hknance/widgets/main_app_button.dart';
import 'package:hknance/widgets/main_loading.dart';
import 'package:hknance/widgets/main_logout_button.dart';
import '../../utils/routing_animation.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../on_boarding_screen.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<UserBloc>().state.userModel;
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return BlocConsumer<SignOutCubit, SignOutState>(
      listener: (context, state) {
        if (state.loadingStatus == LoadingStatus.error) {
          showErrorSnackBar(
            context: context,
            errorMessage: state.errorHandler.message,
          );
        }
        if (state.loadingStatus == LoadingStatus.loaded) {
          Navigator.pushAndRemoveUntil(
            context,
            RoutingAnimation.leftToRight(screen:const OnBoardingScreen()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: MainAppBar(
            title: 'settings'.tr,
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
          body: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              CircleAvatar(
                radius: 35.r,
                backgroundColor: AppColors.primaryDark,
                backgroundImage: userModel.profilePicture.isNotEmpty
                    ? NetworkImage(
                  userModel.profilePicture,
                )
                    : AssetImage('assets/icons/profile-icon-9.png')
                as ImageProvider,
              ),
              SizedBox(
                height: 10.h,
              ),
              MainAppButton(
                label: 'edit_picture'.tr,
                height: 30.h,
                width: 100.w,
                onTap: () {},
                borderRadius: 2.r,
                backgroundColor: Colors.white,
                fontColor: Colors.blue,
                splashColor: Colors.blueAccent,
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTexts.body(
                      text: 'name'.tr,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTexts.body(
                            text: userModel.name,
                            fontSize: 15.sp,
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 28.w,
              vertical: bottomPadding == 0 ? 20.h : bottomPadding.h,
            ),
            child: state.loadingStatus == LoadingStatus.loading
                ? const MainLoading(
                    color: Colors.redAccent,
                  )
                : MainLogoutButton(),
          ),
        );
      },
    );
  }
}
