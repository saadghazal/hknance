part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final LoadingStatus loadingStatus;
  final ErrorHandler errorHandler;

  const SignInState({
    required this.loadingStatus,
    required this.errorHandler,
  });

  factory SignInState.initial(){
    return SignInState(loadingStatus: LoadingStatus.initial, errorHandler: ErrorHandler.noError(),);
  }

  @override
  String toString() {
    return 'SignInState{loadingStatus: $loadingStatus, errorHandler: $errorHandler}';
  }

  @override
  List<Object> get props => [loadingStatus, errorHandler];

  SignInState copyWith({
    LoadingStatus? loadingStatus,
    ErrorHandler? errorHandler,
  }) {
    return SignInState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      errorHandler: errorHandler ?? this.errorHandler,
    );
  }
}
