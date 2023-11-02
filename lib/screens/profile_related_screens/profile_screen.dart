import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/utils/theme/app_texts.dart';
import 'package:hknance/view_controllers/community_cubit/community_cubit.dart';
import 'package:hknance/view_controllers/sign_up_cubit/sign_up_cubit.dart';

import 'package:hknance/view_controllers/user_bloc/user_bloc.dart';
import 'package:hknance/widgets/post_related_widgets/post_place_holder.dart';

import 'package:hknance/widgets/profile_related_widgets/profile_header.dart';

import '../../data_models/post_data_model.dart';
import '../../widgets/main_loading.dart';
import '../../widgets/post_related_widgets/post_widget.dart';
import '../post_related_screens/post_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> questions = [
    'How can i make money faster? Any advice?',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquet nibh praesent tristique magna sit amet. Neque volutpat ac tincidunt vitae semper. Volutpat sed cras ornare arcu dui vivamus arcu. Eu volutpat odio facilisis mauris sit amet. Elit sed vulputate mi sit amet. Adipiscing at in tellus integer. Pretium nibh ipsum consequat nisl. Urna condimentum mattis pellentesque id nibh tortor id aliquet lectus. Viverra accumsan in nisl nisi scelerisque eu ultrices vitae auctor. Sociis natoque penatibus et magnis. Risus nec feugiat in fermentum posuere.',
    'How to get benefits from selling a house that is too old?',
  ];

  @override
  Widget build(BuildContext context) {
    final userPostsState = context.watch<CommunityCubit>().state;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: 0,
          ),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 1.h,
                    ),
                  ]),
                ),
              ];
            },
            body: Column(
              children: [
                ProfileHeader(
                  userModel: state.userModel,
                  postsNumber: userPostsState.userPosts.length,
                ),
                SizedBox(
                  height: 10.h,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('community')
                        .orderBy('createdAt', descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: AppTexts.title2(
                              text: 'No Posts',
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          final userPosts = snapshot.data!.docs
                              .where((element) =>
                                  element.data()['user_id'] ==
                                  state.userModel.id)
                              .toList();
                          return Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.only(top: 20.h),
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10.h,
                              ),
                              itemBuilder: (context, index) {
                                final post = PostModel.fromJson(
                                  userPosts[index].data(),
                                );
                                return PostWidget(
                                  postModel: post,
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => MultiBlocProvider(
                                          providers: [
                                            BlocProvider.value(
                                              value: context
                                                  .read<CommunityCubit>(),
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
                              itemCount: userPosts.length,
                            ),
                          );
                        }
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: MainLoading(),
                        );
                      } else {
                        return SizedBox();
                      }
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
