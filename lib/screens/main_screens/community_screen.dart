import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/post_data_model.dart';
import 'package:hknance/utils/routing_animation.dart';
import 'package:hknance/view_controllers/community_cubit/community_cubit.dart';
import 'package:hknance/view_controllers/user_bloc/user_bloc.dart';
import 'package:hknance/widgets/main_loading.dart';

import 'package:hknance/widgets/post_related_widgets/post_widget.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../post_related_screens/add_post_screen.dart';
import '../post_related_screens/post_screen.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<UserBloc>().state.userModel;
    return BlocConsumer<CommunityCubit, CommunityState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTexts.title1(
                    text: 'Community',
                    fontWeight: FontWeight.w600,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        RoutingAnimation.downToUp(
                          screen: MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: context.read<CommunityCubit>(),
                              ),
                              BlocProvider.value(
                                value: context.read<UserBloc>(),
                              ),
                            ],
                            child: const AddPostScreen(),
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(8.r),
                    child: Ink(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.primaryDark,
                      ),
                      child: Icon(
                        Icons.add,
                        color: AppColors.primaryYellow,
                        size: ScreenUtil().deviceType() == DeviceType.tablet
                            ? 22.sp
                            : 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leadingWidth: double.maxFinite,
          ),
          body: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('community')
                    .where('user_id', isNotEqualTo: userModel.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: AppTexts.title2(
                          text: 'No Posts In Community',
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return ListView.separated(
                        padding: EdgeInsets.only(top: 20.h),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10.h,
                        ),
                        itemBuilder: (context, index) {
                          final post = PostModel.fromJson(
                              snapshot.data!.docs[index].data());
                          return PostWidget(
                            postModel: post,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value: context.read<CommunityCubit>(),
                                      ),
                                      BlocProvider.value(
                                        value: context.read<UserBloc>(),
                                      ),
                                    ],
                                    child: PostScreen(
                                      postModel: post,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return ListView.separated(
                      padding: EdgeInsets.only(top: 20.h),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10.h,
                      ),
                      itemBuilder: (context, index) {
                        return MainLoading();
                      },
                      itemCount: 3,
                    );
                  } else {
                    return SizedBox();
                  }
                }),
          ),
        );
      },
    );
  }
}
