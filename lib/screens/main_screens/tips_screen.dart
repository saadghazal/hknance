import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryYellow,
        toolbarHeight: 100.h,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            AppTexts.body(
              text:
                  'Subscribe with us now to get the VIP tips\n Only For 0.45 JOD!',
              fontSize: 15.sp,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              height: 5.h,
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12.r),
              child: Ink(
                height: 40.h,
                width: 180.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.primaryDark,
                ),
                child: Center(
                  child: AppTexts.body(
                    text: 'Subscribe Now',
                    fontSize: 13.sp,
                    textAlign: TextAlign.center,
                    fontColor: AppColors.lightGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: 10.h,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.w),
            //   child: AppTexts.title1(
            //     text: 'Tips',
            //     fontWeight: FontWeight.w600,
            //     fontColor: AppColors.primaryDark,
            //   ),
            // ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTexts.title2(
                    text: 'Daily Tips',
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.primaryDark,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      foregroundColor: AppColors.primaryYellow,
                    ),
                    child: AppTexts.body(
                      text: 'See All',
                      fontSize: 13.sp,
                      fontColor: AppColors.primaryDarkGrey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Column(
              children: List.generate(5, (index) {
                return  Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lightGrey,
                            blurRadius: 10.r,
                            offset: Offset(0, 0),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.w,
                                right: 15.w,
                                top: 10.h
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppTexts.body(
                                  text: 'Headline',
                                  fontSize:
                                  ScreenUtil().deviceType() == DeviceType.tablet
                                      ? 20.sp
                                      : 17.sp,
                                  isHeadline: true,
                                ),
                                Image.asset(
                                  'assets/icons/light-bulb.png',
                                  height: 20.h,
                                  width: 20.w,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //     horizontal: 15.w,
                          //   ),
                          //   child: AppTexts.body(
                          //     text: 'Description',
                          //     fontSize:
                          //         ScreenUtil().deviceType() == DeviceType.tablet
                          //             ? 17.sp
                          //             : 14.sp,
                          //     fontColor: Colors.grey,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10.h,
                          // ),
                          Container(
                            height: 130.h,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/icons/new_demo.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: Material(
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(12.r),
                                child: Ink(
                                  height: 30.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: AppColors.primaryDark,
                                  ),
                                  child: Center(
                                    child: AppTexts.body(
                                      text: 'Show Details',
                                      fontSize: 13.sp,
                                      textAlign: TextAlign.center,
                                      fontColor: AppColors.lightGrey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                );
              }),


            )
          ],
        ),
      ),
    );
  }
}
