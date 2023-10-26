import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hknance/data_models/post_data_model.dart';
import 'package:hknance/utils/errors/error_handler.dart';

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
}
