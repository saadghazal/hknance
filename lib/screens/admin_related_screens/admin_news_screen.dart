import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/screens/admin_related_screens/add_new_screen.dart';
import 'package:hknance/utils/routing_animation.dart';
import 'package:hknance/utils/theme/app_colors.dart';
import 'package:hknance/utils/theme/app_texts.dart';
import 'package:intl/intl.dart';

class AdminNewsScreen extends StatelessWidget {
  const AdminNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/logo/hknance_logo.jpg',
          height: 70.h,
        ),
        centerTitle: true,
        toolbarHeight:
            ScreenUtil().deviceType() == DeviceType.tablet ? 70.h : 40.h,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              AppTexts.title3(
                text: 'App News',
                fontWeight: FontWeight.w600,
                fontColor: AppColors.primaryDark,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                // height: 80.h,
                width: double.maxFinite,
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lightGrey.withOpacity(0.5),
                      blurRadius: 10.r,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 45.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/icons/news_cover.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTexts.body(
                            text: 'New Title',
                            fontSize: 14.sp,
                            fontColor: AppColors.primaryDark,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          AppTexts.body(
                            text:
                                '${DateFormat.yMMMMEEEEd().format(DateTime.now()).split(',')[0]}, ${DateFormat.yMd().format(DateTime.now())}',
                            fontSize: 12.sp,
                            fontColor: AppColors.primaryDarkGrey,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          RoutingAnimation.downToUp(
                            screen: AddNewScreen(
                              isEditing: true,
                              title: 'New Title',
                              newCover: 'assets/icons/news_cover.jpg',
                              newBody:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.edit,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context).push(
            RoutingAnimation.downToUp(
              screen: AddNewScreen(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(50.r),
        child: Ink(
          height: 50.h,
          width: 50.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryDark,
          ),
          child: const Icon(
            Icons.add,
            color: AppColors.primaryYellow,
          ),
        ),
      ),
    );
  }
}
