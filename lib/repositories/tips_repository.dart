import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hknance/utils/errors/error_handler.dart';

import '../data_models/tip_data_model.dart';

class TipsRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  const TipsRepository({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseStorage firebaseStorage,
  })  : _firebaseFirestore = firebaseFirestore,
        _firebaseStorage = firebaseStorage;
  Future<void> addTip({
    required TipModel tipModel,
    required File coverFile,
  }) async {
    try {
      await _firebaseStorage
          .ref()
          .child('tips/${tipModel.tipId}')
          .putFile(coverFile);
      final coverLink = await _firebaseStorage
          .ref()
          .child('tips/${tipModel.tipId}')
          .getDownloadURL();
      await _firebaseFirestore.collection('tips').doc(tipModel.tipId).set({
        'tip_id': tipModel.tipId,
        'tip_description': tipModel.tipDescription,
        'tip_cover': coverLink,
        'tip_title': tipModel.tipTitle,
        'is_VIP': tipModel.isVIP,
        'tip_type': tipModel.tipTypeModel.toJSON(),
        'tip_categories': tipModel.tipCategories.map((e) => e.toJSON()).toList(),
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

  Future<void> updateTip({
    required TipModel tipModel,
  }) async {
    try {
      await _firebaseFirestore.collection('tips').doc(tipModel.tipId).update({
        'tip_description': tipModel.tipDescription,
        'tip_title': tipModel.tipTitle,
      });
    } on FirebaseException catch (e) {
      throw ErrorHandler(
        code: e.code,
        message: e.message ?? 'Unexpected Error',
        plugin: e.plugin,
      );
    }
  }

  Future<void> deleteTip({
    required String tipId,
  }) async {
    try {
      await _firebaseStorage.ref().child('tips/$tipId').delete();
      await _firebaseFirestore.collection('tips').doc(tipId).delete();
    } on FirebaseException catch (e) {
      throw ErrorHandler(
        code: e.code,
        message: e.message ?? 'Unexpected Error',
        plugin: e.plugin,
      );
    }
  }
}
