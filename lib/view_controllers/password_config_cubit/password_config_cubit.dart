import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'password_config_state.dart';

class PasswordConfigCubit extends Cubit<PasswordConfigState> {
  PasswordConfigCubit() : super(PasswordConfigState.initial());

  void togglePasswordStatus() {
    if (state.passwordStatus == PasswordStatus.hidden) {
      emit(
        state.copyWith(
          passwordStatus: PasswordStatus.notHidden,
        ),
      );
    } else {
      emit(
        state.copyWith(
          passwordStatus: PasswordStatus.hidden,
        ),
      );
    }
  }
  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();

  }
}
