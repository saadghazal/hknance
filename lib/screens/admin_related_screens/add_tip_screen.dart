import 'package:flutter/material.dart';
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
import 'package:hknance/widgets/main_app_button.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../view_controllers/image_picker_cubit/image_picker_cubit.dart';
import '../../widgets/main_app_bar.dart';
import '../../widgets/main_text_field.dart';

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
  bool? isSL;

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
                MainAppButton(
                  label: 'اضف تصنيف النصيحة',
                  height: 45.h,
                  width: double.maxFinite,
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        titlePadding: EdgeInsets.zero,
                        actionsPadding: EdgeInsets.zero,
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        buttonPadding: EdgeInsets.zero,
                        iconPadding: EdgeInsets.zero,
                        insetPadding: EdgeInsets.zero,
                        content: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 10.h,
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppTexts.body(
                                text: 'اختر نوع التصنيف',
                                fontSize: 18.sp,
                                textAlign: TextAlign.center,
                                fontColor: AppColors.primaryDark,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isSL = false;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        height: 40.h,
                                        duration: Duration(milliseconds: 200),
                                        decoration: BoxDecoration(
                                          color: isSL == null
                                              ? Colors.white
                                              : !isSL!
                                                  ? AppColors.primaryYellow
                                                  : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          border: Border.all(
                                            color: AppColors.primaryDarkGrey
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: AppTexts.body(
                                          fontSize: 15.sp,
                                          text: "TP",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isSL = true;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        height: 40.h,
                                        duration: Duration(milliseconds: 200),
                                        decoration: BoxDecoration(
                                          color: isSL == null
                                              ? Colors.white
                                              : isSL!
                                                  ? AppColors.primaryYellow
                                                  : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          border: Border.all(
                                            color: AppColors.primaryDarkGrey
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: AppTexts.body(
                                          fontSize: 15.sp,
                                          text: "SL",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              MainTextField(
                                controller: tpSlController,
                                autoFocus: true,
                                hintText: 'ادخل رقم التصنيف',
                                onChanged: (value) {
                                  setState(() {
                                    tpSlController.text = value;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              MainAppButton(
                                label: 'save'.tr,
                                height: 35.h,
                                width: double.maxFinite,
                                fontSize: ScreenUtil().deviceType() ==
                                        DeviceType.tablet
                                    ? 18.sp
                                    : 16.sp,
                                onTap: () {
                                  Navigator.pop(context);
                                  tpSlController.clear();
                                },
                                borderRadius: 12.r,
                                backgroundColor: AppColors.primaryDark,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              MainAppButton(
                                label: 'cancel'.tr,
                                height: 35.h,
                                width: double.maxFinite,
                                fontSize: ScreenUtil().deviceType() ==
                                        DeviceType.tablet
                                    ? 18.sp
                                    : 16.sp,
                                onTap: () async {
                                  Navigator.pop(context);
                                },
                                borderRadius: 12.r,
                                fontColor: AppColors.primaryDark,
                                backgroundColor: AppColors.lightGrey,
                                splashColor: AppColors.primaryDark,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  borderRadius: 12.r,
                ),
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
          tipTitle: titleController.text,
          tipModel: widget.tipModel,
        ),
      ),
    );
  }
}
