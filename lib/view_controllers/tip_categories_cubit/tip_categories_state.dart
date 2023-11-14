part of 'tip_categories_cubit.dart';

enum SLState {
  notInserted,
  inserted,
}

enum SelectedCategoryStatus {
  unknown,
  tp,
  sl,
}

class TipCategoriesState extends Equatable {
  List<TipCategory> tipCategories;
  final SelectedCategoryStatus selectedStatus;
  final SLState slState;

  TipCategoriesState({
    required this.tipCategories,
    required this.slState,
    required this.selectedStatus,
  });

  factory TipCategoriesState.initial() {
    return TipCategoriesState(
      tipCategories: [],
      slState: SLState.notInserted,
      selectedStatus: SelectedCategoryStatus.unknown,
    );
  }

  @override
  List<Object> get props => [
        tipCategories,
        slState,
        selectedStatus,
      ];

  TipCategoriesState copyWith({
    List<TipCategory>? tipCategories,
    SelectedCategoryStatus? selectedStatus,
    SLState? slState,
  }) {
    return TipCategoriesState(
      tipCategories: tipCategories ?? this.tipCategories,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      slState: slState ?? this.slState,
    );
  }
}
