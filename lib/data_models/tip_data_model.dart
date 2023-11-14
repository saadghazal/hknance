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
  final List<TipCategory> tipCategories;
  final TipTypeModel tipTypeModel;
  final bool isVIP;
  final DateTime createdAt;

  TipModel({
    String? id,
    required this.tipTitle,
    required this.tipCover,
    required this.tipDescription,
    required this.isVIP,
    required this.createdAt,
    required this.tipTypeModel,
    required this.tipCategories,
  }) : tipId = id ?? uuid.v1();

  @override
  List<Object> get props =>
      [
        tipId,
        tipTitle,
        tipCover,
        tipDescription,
        isVIP,
        tipCategories,
        tipTypeModel,
        createdAt,
      ];

  Map<String, dynamic> toJson() {
    return {
      'tip_id': tipId,
      'tip_title': tipTitle,
      'tip_cover': tipCover,
      'tip_description': tipDescription,
      'is_VIP': isVIP,
      'tip_type': tipTypeModel.toJSON(),
      'tip_categories':
      tipCategories.map((element) => element.toJSON()).toList(),
      'createdAt': createdAt,
    };
  }

  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      id: json['tip_id'] as String,
      tipTitle: json['tip_title'] as String,
      tipCover: json['tip_cover'] as String,
      tipTypeModel: TipTypeModel.fromJSON(json['tip_type']),
      tipCategories: List<TipCategory>.from(json["tip_categories"].map((x) => TipCategory.fromJSON(x))),
      tipDescription: json['tip_description'] as String,
      isVIP: json['is_VIP'] as bool,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }
}

class TipCategory extends Equatable {
  final String type;
  final String number;

  const TipCategory({
    required this.type,
    required this.number,
  });

  @override
  List<Object> get props => [type, number];

  Map<String, dynamic> toJSON() {
    return {
      'type': this.type,
      'number': this.number,
    };
  }

  factory TipCategory.fromJSON(Map<String, dynamic> json) {
    return TipCategory(
      type: json['type'] as String,
      number: json['number'] as String,
    );
  }
}

class TipTypeModel extends Equatable {
  final String type;
  final String adviceTitle;

  const TipTypeModel({
    required this.type,
    required this.adviceTitle,
  });

  @override
  List<Object> get props => [type, adviceTitle];

  Map<String, dynamic> toJSON() {
    return {
      'type': this.type,
      'adviceTitle': this.adviceTitle,
    };
  }

  factory TipTypeModel.fromJSON(Map<String, dynamic> json) {
    return TipTypeModel(
      type: json['type'] as String,
      adviceTitle: json['adviceTitle'] as String,
    );
  }
}
