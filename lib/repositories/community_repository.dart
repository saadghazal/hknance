import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<List<PostModel>> getUserPosts() async {
    try {
      final userId = await StorageService.getUserId();
      final userData = await _firebaseFirestore
          .collection('community')
          .where('user_id', isEqualTo: userId)
          .get();
      final List<PostModel> userPosts = [];
      userData.docs.forEach(
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
}
