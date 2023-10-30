import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class TipModel extends Equatable {

  final String tipId;
  final String tipTitle;
  final String tipCover;
  final String tipDescription;
  final bool isVIP;
  final DateTime createdAt;

   TipModel({
    String? id,
    required this.tipTitle,
    required this.tipCover,
    required this.tipDescription,
    required this.isVIP,
    required this.createdAt,
  }): tipId = id ?? uuid.v1();


  @override
  List<Object> get props =>
      [tipId, tipTitle, tipCover, tipDescription, isVIP, createdAt,];

  Map<String, dynamic> toJson() {
    return {
      'tip_id': tipId,
      'tip_title': tipTitle,
      'tip_cover': tipCover,
      'tip_description': tipDescription,
      'is_VIP': isVIP,
      'createdAt': createdAt,
    };
  }

  factory TipModel.fromMap(Map<String, dynamic> map) {
    return TipModel(
      id: map['tip_id'] as String,
      tipTitle: map['tip_title'] as String,
      tipCover: map['tip_cover'] as String,
      tipDescription: map['tip_description'] as String,
      isVIP: map['is_VIP'] as bool,
      createdAt: map['createdAt'] as DateTime,
    );
  }
}