import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/widgets/main_app_button.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool is280 = false;
  TextEditingController postTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: double.maxFinite,
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child:  Icon(
                    Icons.close,
                    color: AppColors.primaryDark,
                    size: ScreenUtil().deviceType() == DeviceType.tablet ? 26.sp : 24.sp,

                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
                AppTexts.body(
                  text: 'Create Post',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(
                  flex: 2,
                ),
                MainAppButton(
                  label: 'Post',
                  height: 25.h,
                  width: 60.w,
                  onTap: () {
                    final numLines =
                        '\n'.allMatches(postTextController.text).length;
                    print(numLines);
                  },
                  borderRadius: 12.r,
                  borderColor: AppColors.primaryYellow,
                  fontColor: AppColors.primaryYellow,
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16.r,
                        backgroundImage:
                            AssetImage('assets/icons/profile_photo.png'),
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
                      AppTexts.body(
                        text: '${postTextController.text.length}/300',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        fontColor:
                            is280 ? Colors.redAccent : AppColors.primaryYellow,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextFormField(
                    autofocus: true,
                    cursorColor: AppColors.primaryYellow,
                    controller: postTextController,
                    maxLines: 15,
                    textInputAction: TextInputAction.newline,
                    onChanged: (value) {
                      if (postTextController.text.length >= 280) {
                        setState(() {
                          is280 = true;
                        });
                      } else {
                        setState(() {
                          is280 = false;
                        });
                      }
                      setState(() {});
                    },
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                          ? 14.sp
                          : null,
                    ),
                    maxLength: 300,
                    decoration: InputDecoration(
                      hintText: 'What\'s on your mind?',
                      counterText: '',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: AppColors.primaryDark.withOpacity(0.45),
                        fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                            ? 14.sp
                            : null,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
