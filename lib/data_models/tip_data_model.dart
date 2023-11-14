import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hknance/view_controllers/tip_type_cubit/tip_type_cubit.dart';
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
  }) : tipId = id ?? uuid.v1();

  @override
  List<Object> get props => [
        tipId,
        tipTitle,
        tipCover,
        tipDescription,
        isVIP,
        createdAt,
      ];

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

  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      id: json['tip_id'] as String,
      tipTitle: json['tip_title'] as String,
      tipCover: json['tip_cover'] as String,
      tipDescription: json['tip_description'] as String,
      isVIP: json['is_VIP'] as bool,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }
}

class TipCategory{
  final String type;
  final String number;

  const TipCategory({
    required this.type,
    required this.number,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'number': number,
    };
  }


}