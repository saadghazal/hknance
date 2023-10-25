import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hknance/utils/errors/error_handler.dart';
import 'package:hknance/view_controllers/sign_up_cubit/sign_up_cubit.dart';

import '../../repositories/auth_repository.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final AuthRepository _authRepository;
  SignOutCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignOutState.initial());

  Future<void> signOut() async {
    try {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.loading,
        ),
      );
      await _authRepository.logout();
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.loaded,
        ),
      );
    } on ErrorHandler catch (e) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          errorHandler: e,
        ),
      );
    }
  }
}
