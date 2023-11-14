import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/errors/error_snack_bar.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../view_controllers/tip_categories_cubit/tip_categories_cubit.dart';
import '../main_app_button.dart';
import '../main_text_field.dart';

class AddTipCategoryDialog extends StatelessWidget {
  const AddTipCategoryDialog({
    super.key,
    required this.tpSlController,
  });

  final TextEditingController tpSlController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TipCategoriesCubit, TipCategoriesState>(
      builder: (context, state) {
        return AlertDialog(
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
                state.slState == SLState.inserted
                    ? SizedBox(
                  height: 40.h,
                      width: double.maxFinite,
                      child: buildCategorySlot(
                          context: context,
                          selectCondition: true,
                          title: "TP",
                          onTap: () {
                            context.read<TipCategoriesCubit>().selectCategory(
                                  selectedCategoryStatus:
                                      SelectedCategoryStatus.tp,
                                );
                          },
                        ),
                    )
                    : Row(
                        children: [
                          buildCategorySlot(
                            context: context,
                            selectCondition: state.selectedStatus ==
                                SelectedCategoryStatus.tp,
                            title: "TP",
                            onTap: () {
                              context.read<TipCategoriesCubit>().selectCategory(
                                    selectedCategoryStatus:
                                        SelectedCategoryStatus.tp,
                                  );
                            },
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          buildCategorySlot(
                            context: context,
                            selectCondition: state.selectedStatus ==
                                SelectedCategoryStatus.sl,
                            title: "SL",
                            onTap: () {
                              context.read<TipCategoriesCubit>().selectCategory(
                                    selectedCategoryStatus:
                                        SelectedCategoryStatus.sl,
                                  );
                            },
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
                ),
                SizedBox(
                  height: 20.h,
                ),
                MainAppButton(
                  label: 'save'.tr,
                  height: 35.h,
                  width: double.maxFinite,
                  fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                      ? 18.sp
                      : 16.sp,
                  onTap: () {
                    if (state.selectedStatus ==
                        SelectedCategoryStatus.unknown) {
                      showErrorSnackBar(
                        context: context,
                        errorMessage: 'اختر تصنيف النصيحة',
                      );
                      return;
                    } else if (tpSlController.text.isEmpty) {
                      showErrorSnackBar(
                        context: context,
                        errorMessage: 'fill_fields'.tr,
                      );
                      return;
                    }
                    context.read<TipCategoriesCubit>().addCategory(
                          type:
                              state.selectedStatus == SelectedCategoryStatus.tp
                                  ? 'TP'
                                  : 'SL',
                          number: tpSlController.text,
                        );
                    Navigator.pop(context);
                    context.read<TipCategoriesCubit>().initializeState();
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
                  fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                      ? 18.sp
                      : 16.sp,
                  onTap: () {
                    Navigator.pop(context);
                    context.read<TipCategoriesCubit>().initializeState();
                    tpSlController.clear();
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
        );
      },
    );
  }

  Expanded buildCategorySlot({
    required BuildContext context,
    required String title,
    required bool selectCondition,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          height: 40.h,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: selectCondition ? AppColors.primaryYellow : Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.primaryDarkGrey.withOpacity(0.5),
            ),
          ),
          alignment: Alignment.center,
          child: AppTexts.body(
            fontSize: 15.sp,
            text: title,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
