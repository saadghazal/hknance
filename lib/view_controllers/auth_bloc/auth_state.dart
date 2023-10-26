part of 'auth_bloc.dart';
enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthState extends Equatable {
  final AuthStatus authStatus;

  const AuthState({required this.authStatus});

  factory AuthState.initial(){
    return const AuthState(authStatus: AuthStatus.unknown,);
  }

  @override
  List<Object> get props => [authStatus];

  AuthState copyWith({
    AuthStatus? authStatus,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
    );
  }
}
