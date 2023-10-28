import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hknance/data_models/new_data_model.dart';
import 'package:hknance/utils/errors/error_handler.dart';

class NewsRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  const NewsRepository({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseStorage firebaseStorage,
  })  : _firebaseFirestore = firebaseFirestore,
        _firebaseStorage = firebaseStorage;
  Future<void> addNew({
    required NewModel newModel,
    required File coverFile,
  }) async {
    try {
      await _firebaseStorage
          .ref()
          .child('news/${newModel.newId}')
          .putFile(coverFile);
      final coverLink = await _firebaseStorage
          .ref()
          .child('news/${newModel.newId}')
          .getDownloadURL();
      await _firebaseFirestore.collection('news').doc(newModel.newId).set({
        'new_id': newModel.newId,
        'new_description': newModel.newDescription,
        'new_cover': coverLink,
        'new_title': newModel.newTitle,
        'createdAt': Timestamp.now(),
      });
    } on FirebaseException catch (e) {
      throw ErrorHandler(
        code: e.code,
        message: e.message ?? 'Unexpected Error',
        plugin: e.plugin,
      );
    }
  }
}
