import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../screens/admin_related_screens/add_tip_screen.dart';
import '../../utils/routing_animation.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class AdminTipWidget extends StatelessWidget {
  const AdminTipWidget({
    required this.isVIP,
    super.key,
  });
  final bool isVIP;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey.withOpacity(0.5),
            blurRadius: 10.r,
            offset: const Offset(0, 0),
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
                isVIP
                    ? vipWidget()
                    : AppTexts.body(
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
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                RoutingAnimation.downToUp(
                  screen: AddTipScreen(
                    isVIP: isVIP,
                    isEditing: true,
                    title: 'Tip Title',
                    tipCover: 'assets/icons/news_cover.jpg',
                    body: 'VIP TIP',
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
    );
  }
}

Widget vipWidget() {
  return Row(
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
  );
}
