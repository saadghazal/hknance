import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/screens/admin_related_screens/add_new_screen.dart';
import 'package:hknance/utils/routing_animation.dart';
import 'package:hknance/utils/theme/app_colors.dart';
import 'package:hknance/utils/theme/app_texts.dart';
import 'package:hknance/view_controllers/image_picker_cubit/image_picker_cubit.dart';
import 'package:hknance/widgets/admin_related_widgets/admin_new_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/floating_add_button.dart';
import 'package:hknance/widgets/main_loading.dart';

import '../../data_models/new_data_model.dart';

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
              StreamBuilder(
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
                      return Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 100.h),
                          itemBuilder: (context, index) {
                            final NewModel newModel = NewModel.fromJson(
                              news[index].data(),
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
                          itemCount: snapshot.data!.docs.length,
                        ),
                      );
                    } else {
                      return AppTexts.title2(
                        text: 'No News Added Yet.',
                        fontColor: AppColors.primaryDark,
                        fontWeight: FontWeight.w500,
                      );
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return MainLoading();
                  } else {
                    return AppTexts.title2(text: 'No news added yet.');
                  }
                },
              ),
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
                  child: AddNewScreen(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
