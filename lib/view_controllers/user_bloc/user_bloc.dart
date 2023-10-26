import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hknance/data_models/user_data_model.dart';
import 'package:hknance/repositories/auth_repository.dart';
import 'package:hknance/repositories/user_repository.dart';
import 'package:hknance/utils/errors/error_handler.dart';
import 'package:hknance/view_controllers/sign_up_cubit/sign_up_cubit.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserState.initial()) {
    on<GetUserDataEvent>((event, emit) async {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));
      try {
        final result = await _userRepository.getUserData();
        print(result.toString());
        emit(
          state.copyWith(
            userModel: result,
            loadingStatus: LoadingStatus.loaded,
          ),
        );
      } on ErrorHandler catch (e) {
        emit(
          state.copyWith(
            errorHandler: e,
            loadingStatus: LoadingStatus.error,
          ),
        );
      }
    });
  }
}
