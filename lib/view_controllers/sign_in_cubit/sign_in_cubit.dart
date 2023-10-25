import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hknance/utils/errors/error_handler.dart';

import '../../repositories/auth_repository.dart';
import '../sign_up_cubit/sign_up_cubit.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository _authRepository;
  SignInCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignInState.initial());

  Future<void> signIn({required String email, required String password}) async {
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      await _authRepository.signIn(
        email: email,
        password: password,
      );
      emit(state.copyWith(loadingStatus: LoadingStatus.loaded));
    } on ErrorHandler catch (e) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.error,
          errorHandler: e,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    print('Sign In Closed');
    return super.close();
  }
}
