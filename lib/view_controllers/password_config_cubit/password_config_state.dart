part of 'password_config_cubit.dart';

enum PasswordStatus {
  notHidden,
  hidden,
}

class PasswordConfigState extends Equatable {
  final PasswordStatus passwordStatus;

  const PasswordConfigState({
    required this.passwordStatus,
  });

  factory PasswordConfigState.initial(){
    return PasswordConfigState(passwordStatus: PasswordStatus.hidden);
  }

  PasswordConfigState copyWith({
    PasswordStatus? passwordStatus,
  }) {
    return PasswordConfigState(
      passwordStatus: passwordStatus ?? this.passwordStatus,
    );
  }

  @override
  List<Object> get props => [passwordStatus];
}


