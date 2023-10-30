import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data_models/tip_data_model.dart';
import '../../utils/theme/app_texts.dart';
import '../main_loading.dart';
import 'admin_tip_widget.dart';

class TipsListWidget extends StatelessWidget {
  const TipsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('tips')
          .orderBy('createdAt', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: AppTexts.title2(text: 'No tips added yet.'),
            );
          } else {
            final tips = snapshot.data!.docs.reversed.toList();
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final tip = TipModel.fromJson(
                  tips[index].data(),
                );
                return AdminTipWidget(
                  tipModel: tip,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10.h,
                );
              },
              itemCount: snapshot.data!.docs.length,
            );
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: MainLoading(),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
