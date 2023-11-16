import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/view_controllers/contorllers_exports.dart';

import 'package:hknance/data_models/tip_data_model.dart';
import 'package:intl/intl.dart';

import '../../screens/admin_related_screens/add_tip_screen.dart';
import '../../utils/routing_animation.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class AdminTipWidget extends StatelessWidget {
  const AdminTipWidget({
    required this.tipModel,
    super.key,
  });

  final TipModel tipModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey.withOpacity(0.5),
            blurRadius: 10.r,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 45.w,
            height: 45.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              image: DecorationImage(
                image: NetworkImage(
                  tipModel.tipCover,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              tipModel.isVIP
                  ? vipWidget(tip: tipModel)
                  : AppTexts.body(
                text: tipModel.tipTitle,
                fontSize: 14.sp,
                fontColor: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 5.h,
              ),
              AppTexts.body(
                text:
                '${DateFormat.yMMMMEEEEd().format(tipModel.createdAt).split(
                    ',')[0]}, ${DateFormat.yMd().format(tipModel.createdAt)}',
                fontSize: 12.sp,
                fontColor: AppColors.primaryDarkGrey,
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                RoutingAnimation.downToUp(
                  screen: MultiBlocProvider(
                    providers: [
                      BlocProvider<ImagePickerCubit>(
                        create: (context) => ImagePickerCubit(),
                      ),
                      BlocProvider<TipTypeCubit>(
                        create: (context) => TipTypeCubit(),
                      ),
                      BlocProvider<TipCategoriesCubit>(
                        create: (context) => TipCategoriesCubit(),
                      ),
                    ],
                    child: AddTipScreen(
                      tipModel: tipModel,
                    ),
                  ),
                ),
              );
            },
            child: Icon(
              Icons.edit,
              color: AppColors.primaryDark,
              size: ScreenUtil().deviceType() == DeviceType.tablet
                  ? 24.sp
                  : 22.sp,
            ),
          ),
        ],
      ),
    );
  }
}

Widget vipWidget({required TipModel tip}) {
  return Row(
    children: [
      Image.asset(
        'assets/icons/premium.png',
        height: 20.h,
        width: 20.w,
        color: AppColors.primaryDark,
      ),
      SizedBox(
        width: 5.w,
      ),
      AppTexts.body(
        text: tip.tipTitle,
        fontSize: 14.sp,
        fontColor: AppColors.primaryDark,
        fontWeight: FontWeight.w500,
      ),
    ],
  );
}
