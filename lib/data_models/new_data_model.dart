import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class NewModel extends Equatable {
  final String newId;
  final String newTitle;
  final String newCover;
  final String newDescription;

  NewModel({
    String? id,
    required this.newTitle,
    required this.newCover,
    required this.newDescription,
  }) : newId = id ?? uuid.v1();

  @override
  List<Object> get props => [
        newId,
        newTitle,
        newCover,
        newDescription,
      ];

  Map<String, dynamic> toJson() {
    return {
      'new_id': newId,
      'new_title': newTitle,
      'new_cover': newCover,
      'new_description': newDescription,
    };
  }

  factory NewModel.fromJson(Map<String, dynamic> json) {
    return NewModel(
      id: json['new_id'] as String,
      newTitle: json['new_title'] as String,
      newCover: json['new_cover'] as String,
      newDescription: json['new_description'] as String,
    );
  }
}
