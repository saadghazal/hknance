part of 'tips_bloc.dart';

class TipsState extends Equatable {
  final LoadingStatus loadingStatus;
  final ErrorHandler errorHandler;

  const TipsState({
    required this.loadingStatus,
    required this.errorHandler,
  });

  factory TipsState.initial() {
    return TipsState(
      loadingStatus: LoadingStatus.initial,
      errorHandler: ErrorHandler.noError(),
    );
  }

  @override
  String toString() {
    return 'TipsState{loadingStatus: $loadingStatus, errorHandler: $errorHandler}';
  }

  @override
  List<Object> get props => [loadingStatus, errorHandler];

  TipsState copyWith({
    LoadingStatus? loadingStatus,
    ErrorHandler? errorHandler,
  }) {
    return TipsState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      errorHandler: errorHandler ?? this.errorHandler,
    );
  }
}
