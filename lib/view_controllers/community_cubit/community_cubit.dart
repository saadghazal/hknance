import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hknance/data_models/comment_data_model.dart';
import 'package:hknance/data_models/post_data_model.dart';
import 'package:hknance/data_models/user_data_model.dart';
import 'package:hknance/utils/errors/error_handler.dart';
import 'package:hknance/view_controllers/sign_up_cubit/sign_up_cubit.dart';

import '../../repositories/community_repository.dart';

part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  final CommunityRepository _communityRepository;
  CommunityCubit({required CommunityRepository communityRepository})
      : _communityRepository = communityRepository,
        super(CommunityState.initial());

  Future<void> addPost({
    required String userId,
    required String username,
    required String userPhoto,
    required String postContent,
  }) async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      final PostModel newPost = PostModel(
        userId: userId,
        postUserName: username,
        postUserPhoto: userPhoto,
        postContent: postContent,
        createdAt: DateTime.now(),
      );
      await _communityRepository.addPost(postModel: newPost);
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.loaded,
        ),
      );
    } on ErrorHandler catch (e) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          errorHandler: e,
        ),
      );
    }
  }

  Future<void> getUserPosts() async {
    try {
      print('getting posts');
      emit(
        state.copyWith(
          getUserPostsLoading: LoadingStatus.loading,
        ),
      );
      final result = await _communityRepository.getUserPosts();
      emit(
        state.copyWith(
          getUserPostsLoading: LoadingStatus.loaded,
          userPosts: result,
        ),
      );
    } on ErrorHandler catch (e) {
      emit(
        state.copyWith(
          getUserPostsLoading: LoadingStatus.error,
          errorHandler: e,
        ),
      );
    }
  }

  Future<void> getCommunityPosts() async {
    try {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.loading,
        ),
      );
      final result = await _communityRepository.getCommunityPosts();
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.loaded,
          communityPosts: result,
        ),
      );
    } on ErrorHandler catch (e) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          errorHandler: e,
        ),
      );
    }
  }

  Future<void> addComment({
    required UserModel userModel,
    required String commentContent,
    required String postId,
  }) async {
    try {
      emit(
        state.copyWith(
          addCommentStatus: LoadingStatus.loading,
        ),
      );
      CommentModel newComment = CommentModel(
        commentUserName: userModel.name,
        commentUserPhoto: userModel.profilePicture,
        commentContent: commentContent,
        createdAt: DateTime.now(),
      );
      await _communityRepository.addComment(
        postId: postId,
        newComment: newComment,
      );
      emit(
        state.copyWith(
          addCommentStatus: LoadingStatus.loaded,
        ),
      );
    } on ErrorHandler catch (e) {
      emit(
        state.copyWith(
          addCommentStatus: LoadingStatus.error,
          errorHandler: e,
        ),
      );
    }
  }
}
