import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/post_data_model.dart';
import 'package:intl/intl.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    required this.postModel,
    required this.onTap,
    super.key,
  });

  final PostModel postModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
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
                  backgroundColor: AppColors.primaryDark,
                  backgroundImage: postModel.postUserPhoto.isNotEmpty
                      ? NetworkImage(
                          postModel.postUserPhoto,
                        )
                      : const AssetImage('assets/icons/profile-icon-9.png')
                          as ImageProvider,
                ),
                SizedBox(
                  width: 7.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTexts.body(
                      text: postModel.postUserName,
                      fontSize: 14.sp,
                      isHeadline: true,
                    ),
                    AppTexts.body(
                        text:
                        '${DateFormat.yMMMMEEEEd().format(postModel.createdAt).split(',')[0]}, ${DateFormat.yMd().format(postModel.createdAt)}, ${DateFormat.jm().format(postModel.createdAt)}',
                        fontSize: 10.sp,
                        fontColor: AppColors.primaryDark.withOpacity(0.7)),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.more_horiz_rounded,
                  color: AppColors.primaryDark,
                  size: ScreenUtil().deviceType() == DeviceType.tablet
                      ? 22.sp
                      : 20.sp,
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            AppTexts.body(
              text: postModel.postContent,
              overflow: TextOverflow.clip,
              fontSize: 13.5.sp,
              fontColor: AppColors.primaryDark,
            ),
            SizedBox(
              height: 5.h,
            ),
            const Divider(),
            InkWell(
              onTap: onTap,
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
    });
  }
}
