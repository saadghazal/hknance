part of 'user_bloc.dart';

class UserState extends Equatable {
  final UserModel userModel;
  final LoadingStatus loadingStatus;
  final ErrorHandler errorHandler;

  const UserState({
    required this.userModel,
    required this.loadingStatus,
    required this.errorHandler,
  });
  factory UserState.initial() {
    return UserState(
      userModel: UserModel.initial(),
      loadingStatus: LoadingStatus.initial,
      errorHandler: ErrorHandler.noError(),
    );
  }

  @override
  List<Object> get props => [userModel, loadingStatus,errorHandler];

  UserState copyWith({
    UserModel? userModel,
    LoadingStatus? loadingStatus,
    ErrorHandler? errorHandler,
  }) {
    return UserState(
      userModel: userModel ?? this.userModel,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      errorHandler: errorHandler ?? this.errorHandler,
    );
  }
}
