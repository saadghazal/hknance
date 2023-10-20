import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/theme/app_colors.dart';
import 'package:hknance/theme/app_texts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 40.h,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_rounded,color: AppColors.primaryDark,),
        ),
        title: AppTexts.title3(text: 'Login',fontWeight: FontWeight.w600,),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(children: [
          SizedBox(
            height: 20.h,
          ),
          AppTexts.title2(text: 'Welcome Back!',fontWeight: FontWeight.w600,),
          SizedBox(
            height: 2.h,
          ),
          // AppTexts.body(text: '', fontSize: 16.sp,),
        ],),
      ),
    );
  }
}
