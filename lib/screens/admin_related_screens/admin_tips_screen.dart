import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../utils/routing_animation.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import 'add_new_screen.dart';

class AdminTipsScreen extends StatelessWidget {
  const AdminTipsScreen({super.key});

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
                text: 'VIP Tips',
                fontWeight: FontWeight.w600,
                fontColor: AppColors.primaryDark,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
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
                        image: const DecorationImage(
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
                          Row(
                            children: [
                              Image.asset(
                                'assets/icons/premium.png',
                                height: 20.h,
                                width: 20.w,
                                color: AppColors.primaryDark,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              AppTexts.body(
                                text: 'Tip Title',
                                fontSize: 14.sp,
                                fontColor: AppColors.primaryDark,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
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
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          RoutingAnimation.downToUp(
                            screen: const AddNewScreen(
                              isTip: true,
                              isEditing: true,
                              title: 'Tip Title',
                              isVIP: true,
                              newCover: 'assets/icons/news_cover.jpg',
                              newBody: 'VIP TIP',
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.edit,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTexts.title3(
                text: 'Daily Tips',
                fontWeight: FontWeight.w600,
                fontColor: AppColors.primaryDark,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
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
                        image: const DecorationImage(
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
                            text: 'Tip Title',
                            fontSize: 14.sp,
                            fontColor: AppColors.primaryDark,
                            fontWeight: FontWeight.w500,
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
                            screen: const AddNewScreen(
                              isTip: true,
                              isEditing: true,
                              title: 'Tip Title',
                              newCover: 'assets/icons/news_cover.jpg',
                              newBody: 'Daily TIP',
                            ),
                          ),
                        );
                      },
                      child: const Icon(
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
              screen: AddNewScreen(isTip: true),
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
