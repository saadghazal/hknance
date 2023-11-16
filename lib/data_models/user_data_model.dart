class UserModel {
  String id;
  String name;
  String profilePicture;
  String email;
  bool isVipUser;

  UserModel({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.email,
    required this.isVipUser,
  });
  factory UserModel.initial() {
    return UserModel(
      id: '',
      name: '',
      profilePicture: '',
      email: '',
      isVipUser: false,
    );
  }
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'profilePicture': profilePicture,
      'email': email,
      'is_vip_user': isVipUser,
    };
  }

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      profilePicture: json['profile_pic'] as String,
      email: json['email'] as String,
      isVipUser: json['is_vip_user'],
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, profilePicture: $profilePicture, email: $email}';
  }
}
