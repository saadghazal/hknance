import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/routing_animation.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../view_controllers/image_picker_cubit/image_picker_cubit.dart';
import '../../widgets/admin_related_widgets/floating_add_button.dart';
import '../../widgets/admin_related_widgets/news_list_widget.dart';
import 'add_new_screen.dart';

class AdminAnalysisScreen extends StatelessWidget {
  const AdminAnalysisScreen({super.key});

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
                text: 'analysis'.tr,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.primaryDark,
              ),
              SizedBox(
                height: 20.h,
              ),
              NewsListWidget(isAnalysis: true,),
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
                  child: AddNewScreen(isAnalysis: true,),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
