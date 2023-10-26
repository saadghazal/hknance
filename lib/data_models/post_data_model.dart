import 'package:uuid/uuid.dart';

import 'comment_data_model.dart';

Uuid uuid = Uuid();

class PostModel {
  String postId;
  final String userId;
  final String postUserName;
  final String postUserPhoto;
  final String postContent;
  final List<CommentModel> comments;
  final DateTime createdAt;

  PostModel({
    String? id,
    required this.userId,
    required this.postUserName,
    required this.postUserPhoto,
    required this.postContent,
    required this.comments,
    required this.createdAt,
  }) : postId = id ?? uuid.v1();

  Map<String, dynamic> toMap() {
    return {
      'post_id': this.postId,
      'user_id': this.userId,
      'post_user_name': this.postUserName,
      'post_user_photo': this.postUserPhoto,
      'post_content': this.postContent,
      'comments': this.comments,
      'createdAt': this.createdAt,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['post_id'] as String,
      userId: json['user_id'] as String,
      postUserName: json['post_user_name'] as String,
      postUserPhoto: json['post_user_photo'] as String,
      postContent: json['post_content'] as String,
      comments: List<CommentModel>.of(
        json['comments'].map(
          (comment) => CommentModel.fromJson(comment),
        ),
      ),
      createdAt: json['createdAt'] as DateTime,
    );
  }
}
