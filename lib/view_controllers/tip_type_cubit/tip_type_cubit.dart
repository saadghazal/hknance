import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tip_type_state.dart';

class TipTypeCubit extends Cubit<TipTypeState> {
  TipTypeCubit() : super(TipTypeState.initial());

  void toggleType({required TipType selectedType}){
    emit(state.copyWith(tipType: selectedType));
  }
}
