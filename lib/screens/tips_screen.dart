import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/tip_data_model.dart';

import '../utils/theme/app_colors.dart';
import '../utils/theme/app_texts.dart';

class TipScreen extends StatelessWidget {
  const TipScreen({required this.tipModel,super.key});
  final TipModel tipModel;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70.h,
            title: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                    backgroundColor: AppColors.primaryDark,
                    child: Icon(Icons.close),),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20.h),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Center(
                  child: AppTexts.title2(
                    text: tipModel.tipTitle,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.primaryDark,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            pinned: true,
            expandedHeight: 230.h,
            backgroundColor: AppColors.primaryDark,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                tipModel.tipCover,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 10.h,left: 16.w,right: 16.w,bottom: bottomPadding == 0 ? 20.h : bottomPadding.h + 10.h,) ,
              child: AppTexts.body(
                text: tipModel.tipDescription,
                fontSize: 16.sp,
                overflow: TextOverflow.clip,
                height: 1.8,

              ),
            ),
          ),
        ],
      ),
    );
  }
}
