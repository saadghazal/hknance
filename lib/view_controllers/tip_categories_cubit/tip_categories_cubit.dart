import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data_models/tip_data_model.dart';

part 'tip_categories_state.dart';

class TipCategoriesCubit extends Cubit<TipCategoriesState> {
  TipCategoriesCubit() : super(TipCategoriesState.initial());
  void addCategory({
    required String type,
    required String number,
  }) {
    var newCategories = <TipCategory>[];
    newCategories.addAll(state.tipCategories);
    if (type == 'SL') {
      emit(
        state.copyWith(
          slState: SLState.inserted,
        ),
      );
    }
    final newCategory = TipCategory(
      type: type,
      number: number,
    );

    newCategories.add(newCategory);
    emit(
      state.copyWith(
        tipCategories: newCategories,
      ),
    );
  }

  void selectCategory({
    required SelectedCategoryStatus selectedCategoryStatus,
  }) {
    emit(
      state.copyWith(
        selectedStatus: selectedCategoryStatus,
      ),
    );
  }

  void initializeState() {
    if (state.slState == SLState.inserted) {
      emit(
        state.copyWith(
          selectedStatus: SelectedCategoryStatus.tp,
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedStatus: SelectedCategoryStatus.unknown,
        ),
      );
    }
  }
}
