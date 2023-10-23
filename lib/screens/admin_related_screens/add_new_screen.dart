import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/utils/theme/app_colors.dart';
import 'package:hknance/utils/theme/app_texts.dart';
import 'package:hknance/widgets/main_app_bar.dart';
import 'package:hknance/widgets/main_app_button.dart';
import 'package:hknance/widgets/main_text_field.dart';

class AddNewScreen extends StatelessWidget {
  const AddNewScreen({
    this.isEditing = false,
    this.title = '',
    this.newBody = '',
    this.newCover = '',
    this.isTip = false,
    this.isVIP = false,
    super.key,
  });
  final bool isEditing;
  final String title;
  final String newCover;
  final String newBody;
  final bool isTip;
  final bool isVIP;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: MainAppBar(
          title: isTip ? 'Add Tip' : 'Add New',
          backIcon: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: AppColors.primaryDark,
            ),
          ),
          actions: isEditing
              ? [
                  Padding(
                    padding: EdgeInsets.only(top: 5.h, right: 16.w),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(50.r),
                      child: Ink(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: const Center(
                          child: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              : null,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                AppTexts.body(
                  text: isTip ? 'Tip Title' : 'New Title',
                  fontSize: 15.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                MainTextField(
                  controller: TextEditingController(),
                  hintText: isEditing
                      ? title
                      : isTip
                          ? 'Enter tip title'
                          : 'Enter the new title',
                  isReadOnly: isEditing,
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppTexts.body(
                  text: isTip ? 'Tip Cover' : 'New Cover',
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
                    image: isEditing
                        ? DecorationImage(
                            image: AssetImage(newCover),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: isEditing
                      ? Padding(
                          padding: EdgeInsets.only(right: 5.w, top: 5.h),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              radius: 12.r,
                              backgroundColor: AppColors.lightGrey,
                              child: Icon(
                                Icons.close,
                                color: AppColors.primaryDark,
                                size: 16.sp,
                              ),
                            ),
                          ),
                        )
                      : Column(
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
                              fontColor:
                                  AppColors.primaryDarkGrey.withOpacity(0.6),
                            ),
                          ],
                        ),
                ),
                Visibility(
                  visible: isTip,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      AppTexts.body(
                        text: 'Tip Type',
                        fontSize: 15.sp,
                        fontColor: AppColors.primaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(12.r),
                        child: Ink(
                          height: 45.h,
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.primaryDarkGrey.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 20.h,
                                width: 20.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isVIP
                                      ? Colors.transparent
                                      : Colors.blueAccent,
                                  border: Border.all(
                                    color: AppColors.primaryDarkGrey
                                        .withOpacity(0.2),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              AppTexts.body(
                                text: 'Daily Tip',
                                fontSize: 14.sp,
                                isHeadline: true,
                              ),
                              Spacer(),
                              Image.asset(
                                'assets/icons/24-hours.png',
                                width: 30.w,
                                color: AppColors.primaryDark,
                                height: 23.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(12.r),
                        child: Ink(
                          height: 45.h,
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.primaryDarkGrey.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 20.h,
                                width: 20.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isVIP
                                      ? Colors.blueAccent
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: AppColors.primaryDarkGrey
                                        .withOpacity(0.2),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              AppTexts.body(
                                text: 'VIP Tip',
                                fontSize: 14.sp,
                                isHeadline: true,
                              ),
                              Spacer(),
                              Image.asset(
                                'assets/icons/premium.png',
                                width: 30.w,
                                color: AppColors.primaryDark,
                                height: 23.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppTexts.body(
                  text: isTip ? 'Tip Body' : 'New Body',
                  fontSize: 15.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                MainTextField(
                  controller: TextEditingController(),
                  hintText: isEditing
                      ? newBody
                      : isTip
                          ? 'Enter tip body'
                          : 'Enter the new content',
                  textInputAction: TextInputAction.newline,
                  isMultiline: true,
                  isReadOnly: isEditing,
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 28.w,
            right: 28.w,
            bottom: bottomPadding == 0 ? 20.h : bottomPadding.h,
          ),
          child: MainAppButton(
            label: 'Save',
            height: 40.h,
            width: double.maxFinite,
            onTap: () {},
            borderRadius: 12.r,
            isIconed: true,
            icon: Icon(
              Icons.save,
              color: AppColors.lightGrey,
              size: 18.sp,
            ),
          ),
        ),
      ),
    );
  }
}
