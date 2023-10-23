import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/utils/theme/app_colors.dart';
import 'package:hknance/utils/theme/app_texts.dart';
import 'package:hknance/widgets/main_app_bar.dart';
import 'package:hknance/widgets/main_text_field.dart';

class AddNewScreen extends StatelessWidget {
  const AddNewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Add New',
        backIcon: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            color: AppColors.primaryDark,
          ),
        ),
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                AppTexts.body(
                  text: 'New Title',
                  fontSize: 15.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                MainTextField(
                  controller: TextEditingController(),
                  hintText: 'Enter the new title',
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppTexts.body(
                  text: 'New Cover',
                  fontSize: 15.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 200.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryDarkGrey.withOpacity(0.2),
                      width: 0.5.w,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/gallery.png',
                        height: 50.h,
                        width: 50.w,
                        fit: BoxFit.cover,
                        color: AppColors.primaryDarkGrey.withOpacity(0.6),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTexts.body(
                        text: 'Add Cover',
                        fontSize: 14.sp,
                        isHeadline: true,
                        fontColor: AppColors.primaryDarkGrey.withOpacity(0.6),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppTexts.body(
                  text: 'New Body',
                  fontSize: 15.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                MainTextField(controller: TextEditingController(), hintText: 'Enter the new content',isMultiline: true,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
