import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hknance/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late StreamSubscription userAuthSubscription;
  final AuthRepository _authRepository;
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthState.initial()) {
    userAuthSubscription = _authRepository.isSignedIn.listen((user) {
      add(CheckAuthStatusEvent(user: user));
    });
    on<CheckAuthStatusEvent>((event, emit) {
      if (event.user == null) {
        print('unauth');
        emit(
          state.copyWith(
            authStatus: AuthStatus.unauthenticated,
          ),
        );
      } else {
        print('auth');
        emit(
          state.copyWith(
            authStatus: AuthStatus.authenticated,
          ),
        );
      }
    });

    on<SignOutEvent>(
      (event, emit) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.unauthenticated,
          ),
        );
      },
    );
  }
  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
