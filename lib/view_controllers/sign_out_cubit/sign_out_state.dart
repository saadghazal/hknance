part of 'sign_out_cubit.dart';

class SignOutState extends Equatable {
  final LoadingStatus loadingStatus;
  final ErrorHandler errorHandler;

  const SignOutState({
    required this.errorHandler,
    required this.loadingStatus,
  });

  factory SignOutState.initial(){
    return SignOutState(errorHandler: ErrorHandler.noError(), loadingStatus: LoadingStatus.initial,);
  }

  @override
  List<Object> get props => [loadingStatus, errorHandler];

  SignOutState copyWith({
    LoadingStatus? loadingStatus,
    ErrorHandler? errorHandler,
  }) {
    return SignOutState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      errorHandler: errorHandler ?? this.errorHandler,
    );
  }
}
