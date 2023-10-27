import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/post_data_model.dart';
import 'package:hknance/data_models/user_data_model.dart';
import 'package:hknance/view_controllers/community_cubit/community_cubit.dart';
import 'package:hknance/view_controllers/user_bloc/user_bloc.dart';

import '../../utils/theme/app_colors.dart';

class CommentTextField extends StatefulWidget {
  const CommentTextField({
    required this.postModel,
    required this.userModel,
    super.key,
  });
  final UserModel userModel;
  final PostModel postModel;

  @override
  State<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  bool isTyping = false;
  TextEditingController commentController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shadowColor: AppColors.primaryDark,
      elevation: 0,
      color: Colors.white,
      child: Container(
        height: ScreenUtil().deviceType() == DeviceType.tablet ? 60.h : 80.h,
        padding: EdgeInsets.only(
          left: 28.w,
          right: 28.w,
          bottom: 20.h,
          top: 5.h,
        ),
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: AppColors.primaryDark,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                height: 40.h,
                child: TextFormField(
                  autofocus: true,
                  cursorColor: AppColors.lightGrey,
                  controller: commentController,
                  onFieldSubmitted: (_) {
                    if (commentController.text.isNotEmpty) {
                      context.read<CommunityCubit>().addComment(
                            userModel: widget.userModel,
                            commentContent: commentController.text,
                            postId: widget.postModel.postId,
                          );
                      commentController.clear();
                      setState(() {

                      });
                    }
                  },
                  onChanged: (_) {
                    if (commentController.text.isNotEmpty) {
                      isTyping = true;
                    } else {
                      isTyping = false;
                    }
                    setState(() {});
                  },
                  style: TextStyle(
                    color: AppColors.lightGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                        ? 12.sp
                        : null,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.primaryDarkGrey,
                    hintText: 'Aa',
                    hintStyle: TextStyle(
                      color: AppColors.lightGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().deviceType() == DeviceType.tablet
                          ? 12.sp
                          : null,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide: const BorderSide(
                        color: AppColors.primaryDarkGrey,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide: const BorderSide(
                        color: AppColors.primaryDarkGrey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.r),
                      borderSide: const BorderSide(
                        color: AppColors.primaryDarkGrey,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: ScreenUtil().deviceType() == DeviceType.tablet
                          ? 10.h
                          : 5.h,
                    ),
                  ),
                ),
              ),
            ),
            isTyping
                ? SizedBox(
                    width: 10.w,
                  )
                : const SizedBox(),
            Visibility(
              visible: isTyping,
              child: InkWell(
                onTap: () {
                  context.read<CommunityCubit>().addComment(
                        userModel: widget.userModel,
                        commentContent: commentController.text,
                        postId: widget.postModel.postId,
                      );
                  commentController.clear();
                  setState(() {

                  });
                },
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                child: Image.asset(
                  'assets/icons/send.png',
                  height: 40.h,
                  width: 20.w,
                  color: AppColors.lightGrey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
