import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/repositories/auth_repository.dart';
import 'package:hknance/screens/profile_related_screens/profile_settings_screen.dart';
import 'package:hknance/utils/routing_animation.dart';
import 'package:hknance/view_controllers/sign_out_cubit/sign_out_cubit.dart';

import 'package:hknance/widgets/main_app_button.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../widgets/post_related_widgets/post_widget.dart';

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
  late ScrollController scrollController;
  bool hideAppBar = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset == 0) {
          setState(() {
            hideAppBar = true;
          });
        } else {
          setState(() {
            hideAppBar = false;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 15.h,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32.r,
                    backgroundImage: const AssetImage(
                      'assets/icons/profile_photo.png',
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTexts.body(
                        text: 'Sa\'ad Ghazal',
                        fontColor: AppColors.primaryDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppTexts.body(
                        text: 'saadghazal@gmail.com',
                        fontColor: AppColors.primaryDark,
                        fontSize: 14.sp,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          AppTexts.body(
                            text: 'Posts',
                            fontSize: 15.sp,
                            fontColor: AppColors.primaryDark,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          AppTexts.body(
                            text: '3',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: MainAppButton(
                      label: 'Profile Settings',
                      height: 40.h,
                      width: double.maxFinite,
                      onTap: () {
                        Navigator.of(context).push(
                          RoutingAnimation.downToUp(
                            screen: BlocProvider<SignOutCubit>(
                              create: (context) => SignOutCubit(
                                  authRepository:
                                      context.read<AuthRepository>()),
                              child: const ProfileSettingsScreen(),
                            ),
                          ),
                        );
                      },
                      borderRadius: 10.r,
                      borderColor: AppColors.primaryDark,
                      backgroundColor: Colors.transparent,
                      fontColor: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                  top: 20.h,
                  bottom: 20.h,
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
                itemBuilder: (context, index) => PostWidget(
                  postContent: questions[index],
                  userImage: 'assets/icons/profile_photo.png',
                ),
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
