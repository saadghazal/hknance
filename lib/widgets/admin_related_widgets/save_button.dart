import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme/app_colors.dart';
import '../main_app_button.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({required this.onTap,super.key,});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return Padding(
      padding: EdgeInsets.only(
        left: 28.w,
        right: 28.w,
        bottom: bottomPadding == 0 ? 20.h : bottomPadding.h,
      ),
      child: MainAppButton(
        label: 'Save',
        height: 40.h,
        width: double.maxFinite,
        onTap: onTap,
        borderRadius: 12.r,
        isIconed: true,
        icon: Icon(
          Icons.save,
          color: AppColors.lightGrey,
          size: 18.sp,
        ),
      ),
    );
  }
}
