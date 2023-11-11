import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../view_controllers/tip_type_cubit/tip_type_cubit.dart';

class TipTypeWidget extends StatelessWidget {
  const TipTypeWidget({this.tipType,super.key});
  final TipType? tipType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TipTypeCubit, TipTypeState>(
      builder: (context, typeState) {
        return Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: tipType != null ? null: () {
                  context
                      .read<TipTypeCubit>()
                      .toggleType(selectedType: TipType.tp);
                },
                borderRadius: BorderRadius.circular(12.r),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  height: 45.h,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.primaryDarkGrey.withOpacity(0.2),
                    ),
                    color: tipType != null ? tipType == TipType.tp ?AppColors.primaryYellow
                        : Colors.white : typeState.tipType == TipType.tp
                        ? AppColors.primaryYellow
                        : Colors.white,
                  ),
                  child: Center(
                    child: AppTexts.body(
                      text: 'TP',
                      fontSize: 16.sp,
                      isHeadline: true,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: InkWell(
                onTap:tipType != null ? null: () {
                  context
                      .read<TipTypeCubit>()
                      .toggleType(selectedType: TipType.sl);
                },
                borderRadius: BorderRadius.circular(12.r),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  height: 45.h,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.primaryDarkGrey.withOpacity(0.2),
                    ),
                    color:tipType != null ? tipType == TipType.sl ?AppColors.primaryYellow
                        : Colors.white : typeState.tipType == TipType.sl
                        ? AppColors.primaryYellow
                        : Colors.white,
                  ),
                  child: Center(
                    child: AppTexts.body(
                      text: 'SL',
                      fontSize: 16.sp,
                      isHeadline: true,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
