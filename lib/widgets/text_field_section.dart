import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/theme/app_colors.dart';
import '../utils/theme/app_texts.dart';
import 'main_text_field.dart';

class TextFieldSection extends StatelessWidget {
  const TextFieldSection({
    required this.controller,
    required this.title,
    required this.hintText,
    required this.isLastField,
    this.icon,
    super.key,
  });
  final TextEditingController controller;
  final String title;
  final String hintText;
  final Widget? icon;
  final bool isLastField;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts.body(
          text: title,
          fontSize: 15.sp,
          fontColor: AppColors.primaryDark,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(
          height: 10.h,
        ),
        MainTextField(
          controller: controller,
          hintText: hintText,
          textInputAction: isLastField ? TextInputAction.done : TextInputAction.next,
          suffix: icon,
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
