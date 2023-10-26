part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class CheckAuthStatusEvent extends AuthEvent {
  final User? user;

  @override
  List<Object> get props => [];

  const CheckAuthStatusEvent({
    this.user,
  });
}

class SignOutEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
