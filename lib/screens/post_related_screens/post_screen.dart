import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/comment_data_model.dart';
import 'package:hknance/data_models/post_data_model.dart';
import 'package:hknance/view_controllers/user_bloc/user_bloc.dart';
import 'package:hknance/widgets/main_loading.dart';
import 'package:hknance/widgets/post_related_widgets/comment_text_field.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../widgets/post_related_widgets/comment_widget.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({
    required this.postModel,
    super.key,
  });
  final PostModel postModel;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late Stream _commentsStream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentsStream = FirebaseFirestore.instance
        .collection('community')
        .doc(widget.postModel.postId)
        .collection('comments')
        .orderBy('createdAt',descending: true)
        .snapshots();

  }
  @override
  Widget build(BuildContext context) {
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;
    final bottomSafeArea = MediaQuery.of(context).viewPadding.bottom;
    return
       Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: double.maxFinite,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColors.primaryDark,
                    size: ScreenUtil().deviceType() == DeviceType.tablet
                        ? 26.sp
                        : 24.sp,
                  ),
                ),
                SizedBox(
                  width: 6.w,
                ),
                CircleAvatar(
                  radius: 16.r,
                  backgroundColor: AppColors.primaryDark,
                  backgroundImage: widget.postModel.postUserPhoto.isNotEmpty
                      ? NetworkImage(
                          widget.postModel.postUserPhoto,
                        )
                      : AssetImage('assets/icons/profile-icon-9.png')
                          as ImageProvider,
                ),
                SizedBox(
                  width: 7.w,
                ),
                AppTexts.body(
                  text: widget.postModel.postUserName,
                  fontSize: 14.sp,
                  isHeadline: true,
                ),
                const Spacer(),
                const Icon(
                  Icons.more_horiz_rounded,
                  color: AppColors.primaryDark,
                ),
              ],
            ),
          ),
        ),
        body: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: AppTexts.body(
                    text: widget.postModel.postContent,
                    overflow: TextOverflow.clip,
                    fontSize: 13.5.sp,
                    fontColor: AppColors.primaryDark,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Divider(),
                SizedBox(
                  height: 10.h,
                ),
                StreamBuilder(
                  stream: _commentsStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                      return MainLoading();
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10.h,
                        ),
                        itemBuilder: (context, index) {
                          final comment = CommentModel.fromJson(
                            snapshot.data!.docs[index].data(),
                          );
                          return CommentWidget(
                            commentModel: comment,
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: keyboardPadding == 0
                      ? bottomSafeArea == 0
                          ? 80.h
                          : ScreenUtil().deviceType() == DeviceType.tablet
                              ? bottomSafeArea.h + 40.h
                              : bottomSafeArea.h + 20.h
                      : keyboardPadding / 3,
                )
              ],
            ),
          ),
        ),),
        bottomSheet: CommentTextField(
          postModel: widget.postModel,
          userModel: context.read<UserBloc>().state.userModel,
        ),

    );
  }
}
