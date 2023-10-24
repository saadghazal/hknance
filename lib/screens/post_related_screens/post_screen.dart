import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/widgets/post_related_widgets/comment_text_field.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../widgets/post_related_widgets/comment_widget.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({
    required this.userText,
    required this.userPhoto,
    super.key,
  });
  final String userText;
  final String userPhoto;

  @override
  Widget build(BuildContext context) {
    final bottomSafeArea = MediaQuery.of(context).viewPadding.bottom;
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: double.maxFinite,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColors.primaryDark,
                    size: ScreenUtil().deviceType() == DeviceType.tablet
                        ? 26.sp
                        : 24.sp,
                  ),
                ),
                SizedBox(
                  width: 6.w,
                ),
                CircleAvatar(
                  radius: 16.r,
                  backgroundImage: AssetImage(userPhoto),
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
          ),
        ),
        body: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: AppTexts.body(
                    text: userText,
                    overflow: TextOverflow.clip,
                    fontSize: 13.5.sp,
                    fontColor: AppColors.primaryDark,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Divider(),
                SizedBox(
                  height: 10.h,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.h,
                  ),
                  itemBuilder: (context, index) {
                    return CommentWidget(
                      userImage: userPhoto,
                      commentText: 'How are you',
                    );
                  },
                  itemCount: 10,
                ),
                SizedBox(
                  height: keyboardPadding == 0
                      ? bottomSafeArea == 0
                          ? 80.h
                          : ScreenUtil().deviceType() == DeviceType.tablet
                              ? bottomSafeArea.h + 40.h
                              : bottomSafeArea.h + 20.h
                      : keyboardPadding / 3,
                )
              ],
            ),
          ),
        ),
        bottomSheet: CommentTextField(),
      ),
    );
  }
}
