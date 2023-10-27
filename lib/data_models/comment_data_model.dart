import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
Uuid uuid = Uuid();
class CommentModel{
  final String commentId;
  final String commentUserName;
  final String commentUserPhoto;
  final String commentContent;
  final DateTime createdAt;

   CommentModel({
    String? id,
    required this.commentUserName,
    required this.commentUserPhoto,
    required this.commentContent,
    required this.createdAt,
  }): commentId = id ?? uuid.v1();

  Map<String, dynamic> toJson() {
    return {
      'comment_id': commentId,
      'comment_user_name': commentUserName,
      'comment_user_photo':commentUserPhoto,
      'comment_content': commentContent,
      'createdAt': Timestamp.now(),
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['comment_id'],
      commentUserName: json['comment_user_name'] as String,
      commentUserPhoto: json['comment_user_photo'] as String,
      commentContent: json['comment_content'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }
}