import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hknance/widgets/home_related_widgets/hot_news_list_widget.dart';
import 'package:hknance/widgets/home_related_widgets/latest_news_list.dart';
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
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.w),
            //   child: AppTexts.title2(
            //     text: 'Hot News',
            //     fontWeight: FontWeight.w600,
            //     fontColor: AppColors.primaryDark,
            //   ),
            // ),
            // SizedBox(
            //   height: 20.h,
            // ),
            // SizedBox(
            //   height: ScreenUtil().deviceType() == DeviceType.tablet
            //       ? 200.h
            //       : 160.h,
            //   child: HotNewsListWidget(),
            // ),
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
           LatestNewsList(),
          ],
        ),
      ),
    );
  }


}
