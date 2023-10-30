import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/tip_data_model.dart';
import 'package:hknance/widgets/tips_screen_related_widgets/vip_tip_widget.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../main_loading.dart';

class VipTipList extends StatefulWidget {
  const VipTipList({super.key});

  @override
  State<VipTipList> createState() => _VipTipListState();
}

class _VipTipListState extends State<VipTipList> {
  PageController pageController = PageController(viewportFraction: 0.85);
  late Stream<QuerySnapshot<Map<String,dynamic>>> stream;
  var currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream = FirebaseFirestore.instance
        .collection('tips')
        .orderBy('createdAt', descending: false)
        .snapshots();
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final allTips = snapshot.data!.docs.reversed.toList();
            final vipTips = allTips.where((element) => element.data()['is_VIP'] == true).toList();
            // if (snapshot.data!.docs.isEmpty) {
            //   return Center(
            //     child: AppTexts.title3(
            //       text: 'No tips added yet.',
            //       fontColor: AppColors.primaryDark,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   );
            // }
            return PageView.builder(
              clipBehavior: Clip.none,
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final vipTip = TipModel.fromJson(vipTips[index].data());
                return buildPageViewChild(
                  index: index,
                  tipModel: vipTip,
                );
              },
              itemCount: vipTips.length,
            );
          } else {
            return Center(
              child: AppTexts.title3(
                text: 'No tips added yet.',
                fontColor: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
            );
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoading();
        } else {
          return Center(
            child: AppTexts.title3(
              text: 'No tips added yet.',
              fontColor: AppColors.primaryDark,
              fontWeight: FontWeight.w500,
            ),
          );
        }
      },
    );
  }

  Widget buildPageViewChild({required int index, required TipModel tipModel}) {
    Matrix4 matrix = Matrix4.identity();
    if (index == currentPageValue.floor()) {
      var currentScale = 1 - (currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = (160) * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == currentPageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (currentPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = (160) * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == currentPageValue.floor() - 1) {
      var currentScale = 1 - (currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = (160) * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, 160 * (1 - _scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix,
      child: VipTipWidget(tipModel: tipModel),
    );
  }
}
