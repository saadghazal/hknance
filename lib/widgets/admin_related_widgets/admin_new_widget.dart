import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/new_data_model.dart';
import 'package:hknance/view_controllers/image_picker_cubit/image_picker_cubit.dart';
import 'package:intl/intl.dart';

import '../../screens/admin_related_screens/add_new_screen.dart';
import '../../utils/routing_animation.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class AdminNewWidget extends StatelessWidget {
  const AdminNewWidget({required this.newModel, super.key});
  final NewModel newModel;

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
            offset: Offset(0, 0),
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
                  newModel.newCover,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts.body(
                  text: newModel.newTitle,
                  fontSize: 14.sp,
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 5.h,
                ),
                AppTexts.body(
                  text:
                      '${DateFormat.yMMMMEEEEd().format(newModel.createdAt).split(',')[0]}, ${DateFormat.yMd().format(newModel.createdAt)}',
                  fontSize: 12.sp,
                  fontColor: AppColors.primaryDarkGrey,
                ),
              ],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                RoutingAnimation.downToUp(
                  screen: BlocProvider(
                    create: (context) => ImagePickerCubit(),
                    child: AddNewScreen(
                      newModel: newModel,
                      isAnalysis: newModel.isAnalysis,
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
