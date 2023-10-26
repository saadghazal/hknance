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

  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'user_id': userId,
      'post_user_name': postUserName,
      'post_user_photo': postUserPhoto,
      'post_content': postContent,
      'comments': comments,
      'createdAt': createdAt,
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
