import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../view_controllers/tip_categories_cubit/tip_categories_cubit.dart';

class TipCategoriesListWidget extends StatelessWidget {
  const TipCategoriesListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TipCategoriesCubit, TipCategoriesState>(
      builder: (context, state) {
        return Column(
          children: List.generate(
            state.tipCategories.length,
                (index) => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45.h,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.primaryDarkGrey
                                  .withOpacity(0.2),
                              width: 1.2),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: AppTexts.body(
                            text: state.tipCategories[index].type,
                            fontSize: 14.sp,
                            isHeadline: true,
                            fontColor: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Container(
                        height: 45.h,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primaryDarkGrey
                                .withOpacity(0.2),
                            width: 1.2,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: AppTexts.body(
                            text: state.tipCategories[index].number,
                            fontSize: 14.sp,
                            isHeadline: true,
                            fontColor: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                index == state.tipCategories.length - 1
                    ? SizedBox(height: 20.h,)
                    : SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}