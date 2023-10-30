import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/tip_data_model.dart';
import 'package:hknance/widgets/tips_screen_related_widgets/tip_widget.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../main_loading.dart';



class UserTipsList extends StatefulWidget {
  const UserTipsList({super.key});

  @override
  State<UserTipsList> createState() => _UserTipsListState();
}

class _UserTipsListState extends State<UserTipsList> {
  late Stream<QuerySnapshot<Map<String,dynamic>>> stream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream = FirebaseFirestore.instance
        .collection('tips')
        .orderBy('createdAt', descending: false)

        .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final tips = snapshot.data!.docs.reversed.toList();
            final dailyTips = tips.where((element) => element.data()['is_VIP']==false).toList();
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: AppTexts.title3(
                  text: 'No tips added yet.',
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 20.h),
              itemBuilder: (context, index) {
                final TipModel newModel = TipModel.fromJson(
                  dailyTips[index].data(),
                );
                return TipWidget(
                  tipModel: newModel,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10.h,
                );
              },
              itemCount: dailyTips.length,
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
}
