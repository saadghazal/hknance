import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hknance/utils/errors/error_handler.dart';
import 'package:hknance/utils/storage_service/storage_service.dart';

import '../data_models/user_data_model.dart';

class UserRepository {
  final FirebaseFirestore _firebaseFirestore;

  const UserRepository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  Future<UserModel> getUserData() async {
    try {
      final userId = await StorageService.getUserId();
      final userSnapshot =
          await _firebaseFirestore.collection('users').doc(userId).get();
      return UserModel.fromJSON(userSnapshot.data()!);
    } on FirebaseException catch (e) {
      throw ErrorHandler(
        code: e.code,
        message: e.message ?? 'Unexpected Error',
        plugin: e.plugin,
      );
    }
  }
}
