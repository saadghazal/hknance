import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hknance/view_controllers/contorllers_exports.dart';
import 'package:hknance/data_models/tip_data_model.dart';
import 'package:hknance/utils/confirm_dialoge.dart';
import 'package:hknance/utils/errors/error_snack_bar.dart';
import 'package:hknance/widgets/admin_related_widgets/add_cover_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/delete_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/save_tip_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/tip_type_selection_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/tip_type_widget.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../widgets/main_app_bar.dart';
import '../../widgets/main_text_field.dart';
import '../../widgets/tips_screen_related_widgets/tip_categories_widget.dart';

class AddTipScreen extends StatefulWidget {
  const AddTipScreen({
    this.tipModel,
    super.key,
  });

  final TipModel? tipModel;

  @override
  State<AddTipScreen> createState() => _AddTipScreenState();
}

class _AddTipScreenState extends State<AddTipScreen> {
  bool isVIP = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController tipTypeTextController = TextEditingController();
  TextEditingController tpSlController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.tipModel != null) {
      titleController.text = widget.tipModel!.tipTitle;
      bodyController.text = widget.tipModel!.tipDescription;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    bodyController.dispose();
    tipTypeTextController.dispose();
    tpSlController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: MainAppBar(
          title: 'add_tip'.tr,
          backIcon: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: AppColors.primaryDark,
            ),
          ),
          actions: widget.tipModel != null
              ? [
                  DeleteWidget(
                    onTap: () {
                      showConfirmDialog(
                        context: context,
                        onDelete: () async {
                          context.read<TipsBloc>().add(
                                DeleteTipEvent(
                                  tipId: widget.tipModel!.tipId,
                                ),
                              );
                          Navigator.pop(context);
                        },
                        title: 'delete_tip'.tr,
                      );
                    },
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
                  text: 'tip_title'.tr,
                  fontSize: 15.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                MainTextField(
                  controller: titleController,
                  hintText: 'tip_title_field'.tr,
                  onChanged: (value) {
                    setState(
                      () {
                        titleController.text = value;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppTexts.body(
                  text: 'vip_tip'.tr,
                  fontSize: 15.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                TipTypeSelectionWidget(
                  icon: 'assets/icons/premium.png',
                  label: 'vip_tips'.tr,
                  onTap: widget.tipModel != null
                      ? null
                      : () {
                          setState(
                            () {
                              isVIP = !isVIP;
                            },
                          );
                        },
                  isSelected:
                      widget.tipModel != null ? widget.tipModel!.isVIP : isVIP,
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppTexts.body(
                  text: 'tip_type'.tr,
                  fontSize: 15.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                SelectTipTypeWidget(
                  controller: tipTypeTextController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                TipCategoriesWidget(tpSlController: tpSlController),
                SizedBox(
                  height: 20.h,
                ),
                AppTexts.body(
                  text: 'tip_cover'.tr,
                  fontSize: 15.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                BlocConsumer<ImagePickerCubit, ImagePickerState>(
                  listener: (context, state) {
                    if (state.imageStatus == ImageStatus.error) {
                      showErrorSnackBar(
                        context: context,
                        errorMessage: 'Please allow access to your photos',
                      );
                    }
                  },
                  builder: (context, state) {
                    return AddCoverWidget(
                      cover: widget.tipModel == null
                          ? state.imageFile.path
                          : widget.tipModel!.tipCover,
                      isNewCover: widget.tipModel != null,
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppTexts.body(
                  text: 'tip_desc'.tr,
                  fontSize: 15.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 10.h,
                ),
                MainTextField(
                  controller: bodyController,
                  hintText: 'tip_desc_field'.tr,
                  textInputAction: TextInputAction.newline,
                  isMultiline: true,
                  textInputType: TextInputType.multiline,
                  onChanged: (value) {
                    setState(
                      () {
                        bodyController.text = value;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SaveTipWidget(
          isVip: isVIP,

          tipDescription: bodyController.text,
          tipAdvice: tipTypeTextController.text,
          tipTitle: titleController.text,
          tipModel: widget.tipModel,
        ),
      ),
    );
  }
}
