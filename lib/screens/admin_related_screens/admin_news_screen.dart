import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/screens/admin_related_screens/add_new_screen.dart';
import 'package:hknance/utils/routing_animation.dart';
import 'package:hknance/utils/theme/app_colors.dart';
import 'package:hknance/utils/theme/app_texts.dart';
import 'package:hknance/widgets/admin_related_widgets/admin_new_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/floating_add_button.dart';
import 'package:intl/intl.dart';

class AdminNewsScreen extends StatelessWidget {
  const AdminNewsScreen({super.key});

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
                text: 'App News',
                fontWeight: FontWeight.w600,
                fontColor: AppColors.primaryDark,
              ),
              SizedBox(
                height: 20.h,
              ),
             AdminNewWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingAddButton(onTap: (){
        Navigator.of(context).push(
          RoutingAnimation.downToUp(
            screen: const AddNewScreen(),
          ),
        );
      }),
    );
  }
}
