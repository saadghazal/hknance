import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/theme/app_texts.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MainAppBar({required this.title,required this.backIcon,super.key});
  final String title;
  final Widget backIcon;

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      // toolbarHeight: 40.h,
      leading: backIcon,
      title: AppTexts.body(
        text: title,
        isHeadline: true,
        fontSize: 14.sp,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.maxFinite,5.h);
}
