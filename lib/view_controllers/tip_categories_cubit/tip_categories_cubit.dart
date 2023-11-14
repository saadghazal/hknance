import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data_models/tip_data_model.dart';

part 'tip_categories_state.dart';

class TipCategoriesCubit extends Cubit<TipCategoriesState> {
  TipCategoriesCubit() : super(TipCategoriesState.initial());
  void addCategory({required String type, required String number}) {
    List<TipCategory> newCategories = state.tipCategories;
    if (type == 'sl') {
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
    emit(state.copyWith(tipCategories: newCategories));
  }
}
