import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class NewModel extends Equatable {
  final String newId;
  final String newTitle;
  final String newCover;
  final String newDescription;
  final bool isAnalysis;
  final DateTime createdAt;

  NewModel({
    String? id,
    required this.newTitle,
    required this.newCover,
    required this.newDescription,
    required this.isAnalysis,
    required this.createdAt,
  }) : newId = id ?? uuid.v1();

  @override
  List<Object> get props => [
        newId,
        newTitle,
        newCover,
        newDescription,
    isAnalysis,
      ];

  Map<String, dynamic> toJson() {
    return {
      'new_id': newId,
      'new_title': newTitle,
      'new_cover': newCover,
      'new_description': newDescription,
      'is_analysis': isAnalysis,
      'createdAt': createdAt,
    };
  }

  factory NewModel.fromJson(Map<String, dynamic> json) {
    return NewModel(
      id: json['new_id'] as String,
      isAnalysis: json['is_analysis'],
      newTitle: json['new_title'] as String,
      newCover: json['new_cover'] as String,
      newDescription: json['new_description'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }
}
