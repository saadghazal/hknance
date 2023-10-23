import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/screens/admin_related_screens/add_new_screen.dart';
import 'package:hknance/utils/routing_animation.dart';
import 'package:hknance/utils/theme/app_colors.dart';

class AdminNewsScreen extends StatelessWidget {
  const AdminNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('No news published to users yet'),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context).push(
            RoutingAnimation.downToUp(
              screen: AddNewScreen(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(50.r),
        child: Ink(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryDark,
          ),
          child: Icon(
            Icons.add,
            color: AppColors.primaryYellow,
          ),
        ),
      ),
    );
  }
}
