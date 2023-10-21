import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hknance/widgets/home_related_widgets/hot_news_list_widget.dart';
import 'package:intl/intl.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppTexts.title2(
                text: 'Hot News',
                fontWeight: FontWeight.w600,
                fontColor: AppColors.primaryDark,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: ScreenUtil().deviceType() == DeviceType.tablet
                  ? 200.h
                  : 160.h,
              child: HotNewsListWidget(),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppTexts.title2(
                text: 'Latest News',
                fontWeight: FontWeight.w600,
                fontColor: AppColors.primaryDark,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lightGrey,
                      blurRadius: 10.r,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r)),
                        image: DecorationImage(
                          image: AssetImage('assets/icons/new_demo.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: AppTexts.body(
                        text: 'Headline',
                        fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                            ? 20.sp
                            : 18.sp,
                        isHeadline: true,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: AppTexts.body(
                        text: 'Description',
                        fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                            ? 16.sp
                            : 14.sp,
                        fontColor: AppColors.primaryDarkGrey.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: AppTexts.body(
                        text: '${DateFormat.yMd().format(DateTime.now())}',
                        fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                            ? 15.sp
                            : 12.sp,
                        fontColor: AppColors.primaryDarkGrey.withOpacity(0.5),
                      ),
                    ),


                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
