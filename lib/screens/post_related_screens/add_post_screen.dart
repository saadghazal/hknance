import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hknance/utils/errors/error_snack_bar.dart';
import 'package:hknance/view_controllers/community_cubit/community_cubit.dart';
import 'package:hknance/view_controllers/sign_up_cubit/sign_up_cubit.dart';
import 'package:hknance/view_controllers/user_bloc/user_bloc.dart';
import 'package:hknance/widgets/main_app_button.dart';
import 'package:hknance/widgets/main_loading.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool is280 = false;
  TextEditingController postTextController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    postTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<UserBloc>().state.userModel;
    return BlocConsumer<CommunityCubit, CommunityState>(
      listener: (context, state) {
        if (state.loadingStatus == LoadingStatus.loaded) {
          Navigator.of(context).pop();
        }
        if (state.loadingStatus == LoadingStatus.error) {
          showErrorSnackBar(
            context: context,
            errorMessage: state.errorHandler.message,
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              leadingWidth: double.maxFinite,
              leading: Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color: AppColors.primaryDark,
                        size: ScreenUtil().deviceType() == DeviceType.tablet
                            ? 26.sp
                            : 24.sp,
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    AppTexts.body(
                      text: 'create_post'.tr,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    state.loadingStatus == LoadingStatus.loading
                        ? MainLoading(
                            color: AppColors.primaryYellow,
                            width: 60.w,
                          )
                        : MainAppButton(
                            label: 'post'.tr,
                            height: 25.h,
                            width: 60.w,
                            onTap: () async {
                              if (postTextController.text.trim().isNotEmpty) {
                                await context.read<CommunityCubit>().addPost(
                                      userId: userModel.id,
                                      username: userModel.name,
                                      userPhoto: userModel.profilePicture,
                                      postContent: postTextController.text,
                                    );
                              }
                            },
                            borderRadius: 12.r,
                            borderColor: AppColors.primaryYellow,
                            fontColor: AppColors.primaryYellow,
                            backgroundColor: Colors.transparent,
                          ),
                  ],
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16.r,
                            backgroundColor: AppColors.primaryDark,
                            backgroundImage: userModel.profilePicture.isNotEmpty
                                ? NetworkImage(
                                    userModel.profilePicture,
                                  )
                                : AssetImage('assets/icons/profile-icon-9.png')
                                    as ImageProvider,
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          AppTexts.body(
                            text: userModel.name,
                            fontSize: 14.sp,
                            isHeadline: true,
                          ),
                          const Spacer(),
                          AppTexts.body(
                            text: '${postTextController.text.length}/300',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            fontColor: is280
                                ? Colors.redAccent
                                : AppColors.primaryYellow,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: TextFormField(
                        autofocus: true,
                        cursorColor: AppColors.primaryYellow,
                        controller: postTextController,
                        maxLines: 15,
                        textInputAction: TextInputAction.newline,
                        onChanged: (value) {
                          if (postTextController.text.length >= 280) {
                            setState(() {
                              is280 = true;
                            });
                          } else {
                            setState(() {
                              is280 = false;
                            });
                          }
                          setState(() {});
                        },
                        style: TextStyle(
                          color: AppColors.primaryDark,
                          fontSize:
                              ScreenUtil().deviceType() == DeviceType.tablet
                                  ? 14.sp
                                  : null,
                        ),
                        maxLength: 300,
                        decoration: InputDecoration(
                          hintText: 'whats_on_mind'.tr,
                          counterText: '',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: AppColors.primaryDark.withOpacity(0.45),
                            fontSize:
                                ScreenUtil().deviceType() == DeviceType.tablet
                                    ? 14.sp
                                    : null,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
