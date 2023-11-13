part of 'tip_type_cubit.dart';

enum TipType {
  unknown,
  BUYNOW,
  SELLNOW,
  SELLLIMIT,
  BUYLIMIT,
  SELLSTOP,
  BUYSTOP,
}

class TipTypeState extends Equatable {
  final TipType selectedType;
  final String selectedTipText;
  final Map<String, TipType> types;

  const TipTypeState({
    required this.selectedType,
    required this.types,
    required this.selectedTipText,
  });

  factory TipTypeState.initial() {
    return const TipTypeState(
      selectedType: TipType.unknown,
      selectedTipText: '',
      types: {
        "BUY NOW": TipType.BUYNOW,
        "SELL NOW": TipType.SELLNOW,
        "BUY LIMIT": TipType.BUYLIMIT,
        "SELL LIMIT": TipType.SELLLIMIT,
        "BUY STOP": TipType.BUYSTOP,
        "SELL STOP": TipType.SELLSTOP,
      },
    );
  }

  @override
  List<Object> get props => [selectedType,types,selectedTipText];

  TipTypeState copyWith({
    TipType? selectedType,
    String? selectedTipText,
    Map<String, TipType>? types,
  }) {
    return TipTypeState(
      selectedType: selectedType ?? this.selectedType,
      selectedTipText: selectedTipText ?? this.selectedTipText,
      types: types ?? this.types,
    );
  }
}
