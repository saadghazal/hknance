class CommentModel{
  final String commentUserName;
  final String commentUserPhoto;
  final String commentContent;
  final DateTime createdAt;

  const CommentModel({
    required this.commentUserName,
    required this.commentUserPhoto,
    required this.commentContent,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'comment_user_name': this.commentUserName,
      'comment_user_photo': this.commentUserPhoto,
      'comment_content': this.commentContent,
      'createdAt': this.createdAt,
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentUserName: json['comment_user_name'] as String,
      commentUserPhoto: json['comment_user_photo'] as String,
      commentContent: json['comment_content'] as String,
      createdAt: json['createdAt'] as DateTime,
    );
  }
}