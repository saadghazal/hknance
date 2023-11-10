import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data_models/new_data_model.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../main_loading.dart';
import 'admin_new_widget.dart';

class NewsListWidget extends StatelessWidget {
  const NewsListWidget({
    required this.isAnalysis,
    super.key,
  });
  final bool isAnalysis;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('news')
          .orderBy('createdAt', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final news = snapshot.data!.docs.reversed.toList();
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: AppTexts.title3(
                  text: 'No News Added Yet.',
                  textAlign: TextAlign.center,
                ),
              );
            }
            final newsOrAnalyticsList = news
                .where((element) => element.data()['is_analysis'] == isAnalysis)
                .toList();
            if(newsOrAnalyticsList.isEmpty) {
              return Center(
                child: AppTexts.title2(
                  text: 'No News Added Yet.',
                  fontColor: AppColors.primaryDark,
                  fontWeight: FontWeight.w500,
                ),
              );
            }
            return Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 100.h),
                itemBuilder: (context, index) {
                  final NewModel newModel = NewModel.fromJson(
                    newsOrAnalyticsList[index].data(),
                  );
                  return AdminNewWidget(
                    newModel: newModel,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10.h,
                  );
                },
                itemCount: newsOrAnalyticsList.length,
              ),
            );
          } else {
            return Center(
              child: AppTexts.title2(
                text: 'No News Added Yet.',
                fontColor: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
            );
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoading();
        } else {
          return Center(child: AppTexts.title2(text: 'No news added yet.'));
        }
      },
    );
  }
}
