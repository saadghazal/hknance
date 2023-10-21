import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';



class HotNewsListWidget extends StatefulWidget {
  const HotNewsListWidget({super.key});

  @override
  State<HotNewsListWidget> createState() => _HotNewsListWidgetState();
}

class _HotNewsListWidgetState extends State<HotNewsListWidget> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      clipBehavior: Clip.none,
      controller: pageController,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return buildPageViewChild(index: index);
      },
      itemCount: 5,
    );
  }

  Widget buildPageViewChild({required int index}) {
    Matrix4 matrix = Matrix4.identity();
    if (index == currentPageValue.floor()) {
      var currentScale = 1 - (currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = (160) * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == currentPageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (currentPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = (160) * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == currentPageValue.floor() - 1) {
      var currentScale = 1 - (currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = (160) * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, 160 * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(
          horizontal:
          ScreenUtil().deviceType() == DeviceType.tablet ? 32.w : 16.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          image: const DecorationImage(
            image: AssetImage('assets/icons/new_demo.jpg'),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDark.withOpacity(0.2),
              blurRadius: 10.r,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height:
            ScreenUtil().deviceType() == DeviceType.tablet ? 70.h : 60.h,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
              color: AppColors.primaryDark.withOpacity(0.7),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts.body(
                  text: 'Hot New',
                  fontColor: AppColors.lightGrey,
                  fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                      ? 20.sp
                      : 17.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: 5.h,
                ),
                AppTexts.body(
                  text: 'Description',
                  fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                      ? 18.sp
                      : 15.sp,
                  fontColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
