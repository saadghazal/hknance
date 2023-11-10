part of 'tip_type_cubit.dart';

enum TipType {
  unknown,
  tp,
  sl,
}

class TipTypeState extends Equatable {
  final TipType tipType;

  const TipTypeState({
    required this.tipType,
  });

  factory TipTypeState.initial(){
    return TipTypeState(tipType: TipType.unknown);
  }

  @override
  List<Object> get props => [tipType];

  TipTypeState copyWith({
    TipType? tipType,
  }) {
    return TipTypeState(
      tipType: tipType ?? this.tipType,
    );
  }
}

