import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/comment_data_model.dart';
import 'package:intl/intl.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({required this.commentModel, super.key});
  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.lightGrey.withOpacity(0.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: AppColors.primaryDark,
                backgroundImage: commentModel.commentUserPhoto.isNotEmpty
                    ? NetworkImage(
                        commentModel.commentUserPhoto,
                      )
                    : const AssetImage('assets/icons/profile-icon-9.png')
                        as ImageProvider,
              ),
              SizedBox(
                width: 7.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTexts.body(
                    text: commentModel.commentUserName,
                    fontSize: 13.sp,
                    isHeadline: true,
                  ),
                  AppTexts.body(
                      text:
                          '${DateFormat.yMMMMEEEEd().format(commentModel.createdAt).split(',')[0]}, ${DateFormat.yMd().format(commentModel.createdAt)}, ${DateFormat.jm().format(commentModel.createdAt)}',
                      fontSize: 10.sp,
                      fontColor: AppColors.primaryDark.withOpacity(0.7)),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: AppTexts.body(
              text: commentModel.commentContent,
              fontSize: 13.sp,
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}
