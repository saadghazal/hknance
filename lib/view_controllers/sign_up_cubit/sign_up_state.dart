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
  final File pictureFile;

  const SignUpState({
    required this.loadingStatus,
    required this.errorHandler,
    required this.pictureFile,
  });

  factory SignUpState.initial() {
    return SignUpState(
      loadingStatus: LoadingStatus.initial,
      errorHandler: ErrorHandler.noError(),
      pictureFile: File(''),
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
    pictureFile,
      ];

  SignUpState copyWith({
    LoadingStatus? loadingStatus,
    ErrorHandler? errorHandler,
    File? pictureFile,
  }) {
    return SignUpState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      errorHandler: errorHandler ?? this.errorHandler,
      pictureFile: pictureFile ?? this.pictureFile,
    );
  }
}
