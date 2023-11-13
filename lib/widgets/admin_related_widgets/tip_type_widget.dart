import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../view_controllers/tip_type_cubit/tip_type_cubit.dart';
import '../main_text_field.dart';

class SelectTipTypeWidget extends StatefulWidget {
  const SelectTipTypeWidget({required this.controller,super.key});
  final TextEditingController controller;

  @override
  State<SelectTipTypeWidget> createState() => _SelectTipTypeWidgetState();
}

class _SelectTipTypeWidgetState extends State<SelectTipTypeWidget>   {
  double opacityLevel = 0;

  @override
  Widget build(BuildContext context) {
    final tipType = context.watch<TipTypeCubit>().state;

    return  GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => BlocProvider.value(
            value: context.read<TipTypeCubit>(),
            child: Container(
              height: 450.h,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Material(
                    child: Ink(
                      height: 5.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppColors.primaryDarkGrey
                            .withOpacity(0.5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocBuilder<TipTypeCubit, TipTypeState>(
                    builder: (context, tipTypeState) {
                      return Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                context
                                    .read<TipTypeCubit>()
                                    .toggleType(
                                  selectedType: tipTypeState
                                      .types.values
                                      .elementAt(index),
                                  text: tipTypeState.types.keys
                                      .elementAt(index),
                                );
                                Navigator.pop(context);
                                Future.delayed(
                                  Duration(milliseconds: 100),
                                      () {
                                    setState(() {
                                      opacityLevel = 1;
                                    });
                                  },
                                );
                              },
                              child: Ink(
                                height: 40.h,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 20.h,
                                      width: 20.w,
                                      padding: EdgeInsets.all(2.r),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors
                                              .primaryDarkGrey
                                              .withOpacity(0.2),
                                          width: 1.2,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor: tipTypeState
                                            .selectedType ==
                                            tipTypeState
                                                .types.values
                                                .elementAt(
                                                index)
                                            ? AppColors
                                            .primaryYellow
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    AppTexts.body(
                                      text: tipTypeState.types.keys
                                          .elementAt(index),
                                      fontSize: 14.sp,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 5.h,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 5.h,
                                )
                              ],
                            );
                          },
                          itemCount: tipTypeState.types.length,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            height: 45.h,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.primaryDarkGrey.withOpacity(0.2),
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.primaryDarkGrey.withOpacity(0.5),
                ),
                SizedBox(
                  width: 10.w,
                ),
                AppTexts.body(
                  text: tipType.selectedType != TipType.unknown
                      ? tipType.selectedTipText
                      : 'اختر نوع النصيحة',
                  fontSize: 14.sp,
                  fontColor: tipType.selectedType != TipType.unknown
                      ? AppColors.primaryDark
                      : AppColors.primaryDarkGrey.withOpacity(0.5),
                ),
              ],
            ),
          ),
          Visibility(
            visible: tipType.selectedType != TipType.unknown,
            replacement: SizedBox(),
            child: AnimatedOpacity(
              opacity: opacityLevel,
              duration: Duration(milliseconds: 500),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  MainTextField(
                    controller: widget.controller,
                    onChanged: (value) {
                      setState(() {
                        setState(() {
                          widget.controller.text = value;
                        });
                      });
                    },
                    hintText: 'ادخل نص نوع النصيحة',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
