class UserModel {
  String id;
  String name;
  String profilePicture;
  String email;

  UserModel({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.email,
  });
  factory UserModel.initial() {
    return UserModel(
      id: '',
      name: '',
      profilePicture: '',
      email: '',
    );
  }
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'profilePicture': profilePicture,
      'email': email,
    };
  }

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      profilePicture: json['profile_pic'] as String,
      email: json['email'] as String,
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, profilePicture: $profilePicture, email: $email}';
  }
}
