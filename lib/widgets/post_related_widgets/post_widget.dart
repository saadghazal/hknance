import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screens/post_related_screens/post_screen.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({required this.postContent,required this.userImage,super.key,});
  final String postContent;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withOpacity(0.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundImage: AssetImage(userImage),
              ),
              SizedBox(
                width: 7.w,
              ),
              AppTexts.body(
                text: 'Username',
                fontSize: 14.sp,
                isHeadline: true,
              ),
              const Spacer(),
              const Icon(
                Icons.more_horiz_rounded,
                color: AppColors.primaryDark,
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          AppTexts.body(
            text: postContent,
            overflow: TextOverflow.clip,
            fontSize: 13.5.sp,
            fontColor: AppColors.primaryDark,
          ),
          SizedBox(
            height: 5.h,
          ),
          const Divider(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PostScreen(
                    userText: postContent,
                    userPhoto: userImage,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(15.r),
            child: SizedBox(
              height: 30.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/chat.png',
                    color: AppColors.primaryDark,
                    height: 18.h,
                    // width: 20.w,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  AppTexts.body(
                    text: 'Comments',
                    fontSize: 12.sp,
                    isHeadline: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
