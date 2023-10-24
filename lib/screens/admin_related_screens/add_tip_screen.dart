import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/widgets/admin_related_widgets/add_cover_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/delete_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/save_button.dart';
import 'package:hknance/widgets/admin_related_widgets/tip_type_selection_widget.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../widgets/main_app_bar.dart';
import '../../widgets/main_text_field.dart';

class AddTipScreen extends StatelessWidget {
  const AddTipScreen({
    required this.isEditing,
    this.title = '',
    this.body = '',
    this.tipCover = '',
    this.isVIP = false,
    super.key,
  });
  final bool isEditing;
  final String title;
  final String body;
  final String tipCover;
  final bool isVIP;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Add Tip',
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
                DeleteWidget(onTap: () {}),
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
                text: 'Tip Title',
                fontSize: 15.sp,
                fontColor: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 10.h,
              ),
              MainTextField(
                controller: TextEditingController(),
                hintText: isEditing ? title : 'Enter tip title',
                isReadOnly: isEditing,
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTexts.body(
                text: 'Tip Cover',
                fontSize: 15.sp,
                fontColor: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 10.h,
              ),
              AddCoverWidget(tipCover: tipCover),
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
              TipTypeSelectionWidget(
                icon: 'assets/icons/24-hours.png',
                label: 'Daily Tip',
                onTap: () {},
                isSelected: !isVIP,
              ),
              SizedBox(
                height: 10.h,
              ),
              TipTypeSelectionWidget(
                icon: 'assets/icons/premium.png',
                label: 'VIP Tip',
                onTap: () {},
                isSelected: isVIP,
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTexts.body(
                text: 'Tip Body',
                fontSize: 15.sp,
                fontColor: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 10.h,
              ),
              MainTextField(
                controller: TextEditingController(),
                hintText: isEditing ? body : 'Enter tip body',
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
    );
  }
}
