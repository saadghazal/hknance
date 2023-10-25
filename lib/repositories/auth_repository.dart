import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hknance/utils/errors/error_handler.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  const AuthRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
    required FirebaseStorage firebaseStorage,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore,
        _firebaseStorage = firebaseStorage;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    File? profilePic,
  }) async {
    try {
      final userCredentials =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String userId = userCredentials.user!.uid;
      if (profilePic != null) {
        final data = await _firebaseStorage
            .ref()
            .child('users/$userId')
            .putFile(profilePic);
        final downloadUrl =
            await data.storage.ref().child('users/$userId').getDownloadURL();
        await _firebaseFirestore
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'id': userCredentials.user!.uid,
          'email': email,
          'profile_pic': downloadUrl,
          'name': name,
        });
      } else {
        await _firebaseFirestore
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'id': userCredentials.user!.uid,
          'email': email,
          'profile_pic': profilePic,
          'name': name,
        });
      }
    } on FirebaseAuthException catch (e) {
      throw ErrorHandler(
        code: e.code,
        message: e.message ?? 'Unexpected Error',
        plugin: e.plugin,
      );
    } on FirebaseException catch (e) {
      throw ErrorHandler(
        code: e.code,
        message: e.message ?? 'Unexpected Error',
        plugin: e.plugin,
      );
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if(e.code == 'INVALID_LOGIN_CREDENTIALS'){
        throw  ErrorHandler(
          code: e.code,
          message: 'Either your email or password are wrong',
          plugin: e.plugin,
        );
      }
      throw ErrorHandler(
        code: e.code,
        message: e.message ?? 'Unexpected Error',
        plugin: e.plugin,
      );
    } on FirebaseException catch (e) {
      throw ErrorHandler(
        code: e.code,
        message: e.message ?? 'Unexpected Error',
        plugin: e.plugin,
      );
    }
  }
  Future<void> logout()async{
    try{
      await _firebaseAuth.signOut();
    }on FirebaseAuthException catch(e){
      throw ErrorHandler(
        code: e.code,
        message: e.message ?? 'Unexpected Error',
        plugin: e.plugin,
      );
    }
    on FirebaseException catch(e){
      throw ErrorHandler(
        code: e.code,
        message: e.message ?? 'Unexpected Error',
        plugin: e.plugin,
      );
    }
  }
}
