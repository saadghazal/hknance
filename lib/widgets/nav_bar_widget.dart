import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hknance/view_controllers/contorllers_exports.dart';
import '../utils/theme/app_colors.dart';
import '../utils/theme/app_texts.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({
    required this.currentIndex,
    required this.onTap,
    this.isAdmin = false,
    super.key,
  });
  final Function(int) onTap;
  final int currentIndex;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: 90.h,
        width: double.maxFinite,
        padding: EdgeInsets.only(
          left: ScreenUtil().deviceType() == DeviceType.tablet ? 30.w : 30.w,
          right: ScreenUtil().deviceType() == DeviceType.tablet ? 30.w : 30.w,
          bottom: bottomPadding == 0 ? 20.h : bottomPadding.h,
          top: 10.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.r),
            topLeft: Radius.circular(20.r),
          ),
          color: AppColors.primaryDark,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDarkGrey.withOpacity(0.2),
              blurRadius: 10.r,
            ),
          ],
        ),
        child: isAdmin
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  navBarItem(
                    condition: currentIndex == 0,
                    onTap: () => onTap(0),
                    icon: 'assets/icons/home_icon.png',
                    label: 'home'.tr,
                  ),
                  navBarItem(
                    condition: currentIndex == 1,
                    onTap: () => onTap(1),
                    icon: 'assets/icons/stats.png',
                    label: 'analysis'.tr,
                  ),
                  navBarItem(
                    condition: currentIndex == 2,
                    onTap: () => onTap(2),
                    icon: 'assets/icons/light-bulb.png',
                    label: 'tips'.tr,
                  ),
                  navBarItem(
                    condition: currentIndex == 3,
                    onTap: () {
                      onTap(3);
                    },
                    icon: 'assets/icons/user.png',
                    label: 'profile'.tr,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  navBarItem(
                    condition: currentIndex == 0,
                    onTap: () => onTap(0),
                    icon: 'assets/icons/home_icon.png',
                    label: 'home'.tr,
                  ),
                  navBarItem(
                    condition: currentIndex == 1,
                    onTap: () => onTap(1),
                    icon: 'assets/icons/stats.png',
                    label: 'analysis'.tr,
                  ),
                  navBarItem(
                    condition: currentIndex == 2,
                    onTap: () => onTap(2),
                    icon: 'assets/icons/light-bulb.png',
                    label: 'tips'.tr,
                  ),
                  navBarItem(
                    condition: currentIndex == 3,
                    onTap: () async {
                      if (currentIndex == 3) {
                        return;
                      }
                      onTap(3);
                      await context.read<CommunityCubit>().getCommunityPosts();
                    },
                    icon: 'assets/icons/globe.png',
                    label: 'community'.tr,
                  ),
                  navBarItem(
                    condition: currentIndex == 4,
                    onTap: () async {
                      if (currentIndex == 4) {
                        return;
                      }
                      onTap(4);
                      await context.read<CommunityCubit>().getUserPosts();
                    },
                    icon: 'assets/icons/user.png',
                    label: 'profile'.tr,
                  ),
                ],
              ),
      ),
    );
  }
}

Widget navBarItem({
  required bool condition,
  required VoidCallback onTap,
  required String icon,
  required String label,
}) {
  return InkWell(
   onTap: onTap,
    child: Ink(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        reverseDuration: const Duration(milliseconds: 200),
        child: Visibility(
          visible: condition,
          replacement: Image.asset(
            icon,
            color: AppColors.lightGrey,
            height: 20.h,
            width: 20.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                color: AppColors.primaryYellow,
                height: 24.h,
                width: 24.w,
              ),
              AppTexts.body(
                text: label,
                fontSize: 12.sp,
                fontColor: AppColors.primaryYellow,
                isHeadline: true,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
