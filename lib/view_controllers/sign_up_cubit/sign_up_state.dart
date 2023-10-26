part of 'sign_up_cubit.dart';

enum LoadingStatus {
  initial,
  loading,
  loaded,
  error,
}

class SignUpState extends Equatable {
  final LoadingStatus loadingStatus;
  final ErrorHandler errorHandler;

  const SignUpState({
    required this.loadingStatus,
    required this.errorHandler,
  });

  factory SignUpState.initial() {
    return SignUpState(
      loadingStatus: LoadingStatus.initial,
      errorHandler: ErrorHandler.noError(),
    );
  }

  @override
  String toString() {
    return 'SignUpState{loadingStatus: $loadingStatus, errorHandler: $errorHandler}';
  }

  @override
  List<Object> get props => [
        loadingStatus,
        errorHandler,
      ];

  SignUpState copyWith({
    LoadingStatus? loadingStatus,
    ErrorHandler? errorHandler,
  }) {
    return SignUpState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      errorHandler: errorHandler ?? this.errorHandler,
    );
  }
}
