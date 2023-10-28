import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hknance/repositories/auth_repository.dart';
import 'package:hknance/utils/errors/error_handler.dart';
import 'package:hknance/utils/storage_service/storage_service.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;

  SignUpCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignUpState.initial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required File pictureFile,
  }) async {
    try {
      await StorageService.setIsAdmin(isAdmin: false);
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.loading,
        ),
      );
      await _authRepository.signUp(
        name: name,
        email: email,
        password: password,
        profilePic: pictureFile,
      );
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
  @override
  Future<void> close() {
    // TODO: implement close
    print("closed");
    return super.close();
  }
}
