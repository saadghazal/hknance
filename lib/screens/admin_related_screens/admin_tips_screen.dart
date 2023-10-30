import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/tip_data_model.dart';
import 'package:hknance/screens/admin_related_screens/add_tip_screen.dart';
import 'package:hknance/widgets/admin_related_widgets/admin_tip_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/floating_add_button.dart';
import 'package:hknance/widgets/admin_related_widgets/tips_list_widget.dart';
import 'package:hknance/widgets/main_loading.dart';

import '../../utils/routing_animation.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../view_controllers/image_picker_cubit/image_picker_cubit.dart';

class AdminTipsScreen extends StatelessWidget {
  const AdminTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              AppTexts.title3(
                text: 'Tips',
                fontWeight: FontWeight.w600,
                fontColor: AppColors.primaryDark,
              ),
              SizedBox(
                height: 20.h,
              ),
              TipsListWidget(),

              // AppTexts.title3(
              //   text: 'Daily Tips',
              //   fontWeight: FontWeight.w600,
              //   fontColor: AppColors.primaryDark,
              // ),
              // SizedBox(
              //   height: 20.h,
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: FloatingAddButton(
          onTap: () {
            Navigator.of(context).push(
              RoutingAnimation.downToUp(
                screen: BlocProvider<ImagePickerCubit>(
                  create: (context) => ImagePickerCubit(),
                  child: AddTipScreen(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
