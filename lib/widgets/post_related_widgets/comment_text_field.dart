import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme/app_colors.dart';


class CommentTextField extends StatefulWidget {
  const CommentTextField({super.key});

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
        height: 80.h,
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
                  onChanged: (_) {
                    if (commentController.text.isNotEmpty) {
                      isTyping = true;
                    } else {
                      isTyping = false;
                    }
                    setState(() {});
                  },
                  style: const TextStyle(
                    color: AppColors.lightGrey,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.primaryDarkGrey,
                    hintText: 'Aa',
                    hintStyle: const TextStyle(
                      color: AppColors.lightGrey,
                      fontWeight: FontWeight.w500,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.r),
                        borderSide:
                        const BorderSide(color: AppColors.primaryDarkGrey)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.r),
                        borderSide:
                        const BorderSide(color: AppColors.primaryDarkGrey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.r),
                        borderSide:
                        const BorderSide(color: AppColors.primaryDarkGrey)),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 5.h,
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
              child: Image.asset(
                'assets/icons/send.png',
                height: 40.h,
                width: 20.w,
                color: AppColors.primaryDarkGrey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
