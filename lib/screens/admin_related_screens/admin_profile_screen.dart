import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/screens/on_boarding_screen.dart';
import 'package:hknance/view_controllers/contorllers_exports.dart';
import 'package:hknance/utils/routing_animation.dart';
import 'package:hknance/utils/theme/app_colors.dart';
import 'package:hknance/utils/theme/app_texts.dart';
import 'package:hknance/widgets/main_logout_button.dart';

import '../../utils/errors/error_snack_bar.dart';
import '../../widgets/main_loading.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('Admin Profile Disposed');
  }

  @override
  Widget build(BuildContext context) {
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
            RoutingAnimation.leftToRight(
              screen: const OnBoardingScreen(),
            ),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.r,
                      offset: Offset(0, 0),
                      color: AppColors.lightGrey,
                    )
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 70.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.primaryDarkGrey, width: 2),
                      image: const DecorationImage(
                        image: AssetImage('assets/logo/hknance_logo.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppTexts.body(
                    text: 'HKNANCE Admin',
                    fontSize: 18.sp,
                    isHeadline: true,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  state.loadingStatus == LoadingStatus.loading
                      ? const MainLoading(
                          color: Colors.redAccent,
                        )
                      : MainLogoutButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
