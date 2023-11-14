part of 'tip_categories_cubit.dart';

enum SLState {
  notInserted,
  inserted,
}

class TipCategoriesState extends Equatable {
  final List<TipCategory> tipCategories;
  final SLState slState;

  const TipCategoriesState({
    required this.tipCategories,
    required this.slState,
  });

  factory TipCategoriesState.initial(){
    return const TipCategoriesState(tipCategories: [], slState: SLState.notInserted);
  }

  @override
  List<Object> get props => [tipCategories, slState];

  TipCategoriesState copyWith({
    List<TipCategory>? tipCategories,
    SLState? slState,
  }) {
    return TipCategoriesState(
      tipCategories: tipCategories ?? this.tipCategories,
      slState: slState ?? this.slState,
    );
  }
}
