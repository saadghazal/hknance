import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/utils/routing_animation.dart';
import 'package:hknance/view_controllers/community_cubit/community_cubit.dart';
import 'package:hknance/view_controllers/sign_up_cubit/sign_up_cubit.dart';
import 'package:hknance/view_controllers/user_bloc/user_bloc.dart';
import 'package:hknance/widgets/post_related_widgets/post_place_holder.dart';

import 'package:hknance/widgets/post_related_widgets/post_widget.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../post_related_screens/add_post_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<String> questions = [
    'How can i make money faster? Any advice?',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquet nibh praesent tristique magna sit amet. Neque volutpat ac tincidunt vitae semper. Volutpat sed cras ornare arcu dui vivamus arcu. Eu volutpat odio facilisis mauris sit amet. Elit sed vulputate mi sit amet. Adipiscing at in tellus integer. Pretium nibh ipsum consequat nisl. Urna condimentum mattis pellentesque id nibh tortor id aliquet lectus. Viverra accumsan in nisl nisi scelerisque eu ultrices vitae auctor. Sociis natoque penatibus et magnis. Risus nec feugiat in fermentum posuere.',
    'How to get benefits from selling a house that is too old?',
  ];
  List<String> profilePictures = [
    'assets/icons/profile_photo.png',
    'assets/icons/avatar-1.png',
    'assets/icons/avatar-2.png',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommunityCubit, CommunityState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        print(state.communityPosts);
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
                            child: AddPostScreen(),
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
            child: state.communityPosts.isEmpty &&
                    state.loadingStatus == LoadingStatus.loaded
                ? Center(
                    child: AppTexts.title2(
                      text: 'No Posts In Community',
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.only(top: 20.h),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10.h,
                    ),
                    itemBuilder: (context, index) {
                      if (state.loadingStatus == LoadingStatus.loading) {
                        return PostPlaceHolder();
                      }
                      final post = context
                          .watch<CommunityCubit>()
                          .state
                          .communityPosts[index];
                      return PostWidget(postModel: post);
                    },
                    itemCount: state.loadingStatus == LoadingStatus.loading
                        ? 3
                        : context
                            .watch<CommunityCubit>()
                            .state
                            .communityPosts
                            .length,
                  ),
          ),
        );
      },
    );
  }
}
