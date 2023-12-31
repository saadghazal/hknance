import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hknance/view_controllers/contorllers_exports.dart';


import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class AddCoverWidget extends StatelessWidget {
  const AddCoverWidget(
      {required this.cover, required this.isNewCover, super.key});
  final String cover;
  final bool isNewCover;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cover.isEmpty
          ? () async {
              await context.read<ImagePickerCubit>().pickImage();
            }
          : null,
      child: Container(
        height: 150.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryDarkGrey.withOpacity(0.2),
            width: 0.5.w,
          ),
          borderRadius: BorderRadius.circular(12.r),
          image: cover.isNotEmpty
              ? DecorationImage(
                  image: isNewCover
                      ? NetworkImage(cover)
                      : FileImage(File(cover)) as ImageProvider,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: cover.isNotEmpty
            ? SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/gallery.png',
                    height: 40.h,
                    width: 40.w,
                    fit: BoxFit.cover,
                    color: AppColors.primaryDarkGrey.withOpacity(0.6),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppTexts.body(
                    text: 'add_cover'.tr,
                    fontSize: 14.sp,
                    isHeadline: true,
                    fontColor: AppColors.primaryDarkGrey.withOpacity(0.6),
                  ),
                ],
              ),
      ),
    );
  }
}
