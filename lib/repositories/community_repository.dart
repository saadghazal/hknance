import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hknance/data_models/comment_data_model.dart';
import 'package:hknance/data_models/post_data_model.dart';
import 'package:hknance/utils/errors/error_handler.dart';
import 'package:hknance/utils/storage_service/storage_service.dart';

class CommunityRepository {
  final FirebaseFirestore _firebaseFirestore;

  const CommunityRepository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  Future<void> addPost({required PostModel postModel}) async {
    try {
      await _firebaseFirestore
          .collection('community')
          .doc(postModel.postId)
          .set(postModel.toJson());
    } on FirebaseException catch (e) {
      throw ErrorHandler(
        code: e.code,
        message: e.message ?? 'Unexpected Error',
        plugin: e.plugin,
      );
    }
  }

  Future<List<PostModel>> getCommunityPosts() async {
    try {
      final userId = await StorageService.getUserId();
      final communityPostsSnapshots = _firebaseFirestore
          .collection('community')
          .where('user_id', isNotEqualTo: userId)
          .snapshots();
      final communityPostsData = await communityPostsSnapshots.elementAt(0);

      final List<PostModel> communityPosts = [];
      communityPostsData.docs.forEach(
        (e) => communityPosts.add(
          PostModel.fromJson(
            e.data(),
          ),
        ),
      );

      return communityPosts;
    } on FirebaseException catch (e) {
      throw ErrorHandler(
        code: e.code,
        message: e.message ?? 'Unexpected Error',
        plugin: e.plugin,
      );
    }
  }

  Future<List<PostModel>> getUserPosts() async {
    try {
      final userId = await StorageService.getUserId();
      final userPostsSnapshots = _firebaseFirestore
          .collection('community')
          .where('user_id', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots();
      final userPostsData = await userPostsSnapshots.elementAt(0);

      final List<PostModel> userPosts = [];
      userPostsData.docs.forEach(
        (e) => userPosts.add(
          PostModel.fromJson(
            e.data(),
          ),
        ),
      );

      return userPosts;
    } on FirebaseException catch (e) {
      throw ErrorHandler(
        code: e.code,
        message: e.message ?? 'Unexpected Error',
        plugin: e.plugin,
      );
    }
  }

  Future<void> addComment({
    required String postId,
    required CommentModel newComment,
  }) async {
    try {
      await _firebaseFirestore
          .collection('community')
          .doc(postId)
          .collection('comments')
          .doc(newComment.commentId)
          .set(newComment.toJson());
    } on FirebaseException catch (e) {
      throw ErrorHandler(
        code: e.code,
        message: e.message ?? 'Unexpected',
        plugin: e.plugin,
      );
    }
  }
}
