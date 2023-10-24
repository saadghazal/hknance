import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/utils/theme/app_colors.dart';
import 'package:hknance/utils/theme/app_texts.dart';
import 'package:hknance/widgets/admin_related_widgets/add_cover_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/delete_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/save_button.dart';
import 'package:hknance/widgets/main_app_bar.dart';
import 'package:hknance/widgets/main_text_field.dart';

class AddNewScreen extends StatelessWidget {
  const AddNewScreen({
    this.isEditing = false,
    this.title = '',
    this.newBody = '',
    this.newCover = '',
    super.key,
  });
  final bool isEditing;
  final String title;
  final String newCover;
  final String newBody;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
          actions: isEditing
              ? [
                  DeleteWidget(onTap: (){})
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
                  hintText: isEditing ? title : 'Enter the new title',
                  isReadOnly: isEditing,
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
                AddCoverWidget(tipCover: newCover),
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
                MainTextField(
                  controller: TextEditingController(),
                  hintText: isEditing ? newBody : 'Enter the new content',
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
        bottomNavigationBar: SaveButton(onTap: () {}),
      ),
    );
  }
}
