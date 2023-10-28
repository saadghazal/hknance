part of 'news_bloc.dart';

class NewsState extends Equatable {
  final LoadingStatus loadingStatus;
  final ErrorHandler errorHandler;
  final List<NewModel> news;

  const NewsState({
    required this.loadingStatus,
    required this.errorHandler,
    required this.news,
  });

  factory NewsState.initial() {
    return NewsState(
      loadingStatus: LoadingStatus.initial,
      errorHandler: ErrorHandler.noError(),
      news: [],
    );
  }

  @override
  List<Object> get props => [loadingStatus, errorHandler, news];

  NewsState copyWith({
    LoadingStatus? loadingStatus,
    ErrorHandler? errorHandler,
    List<NewModel>? news,
  }) {
    return NewsState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      errorHandler: errorHandler ?? this.errorHandler,
      news: news ?? this.news,
    );
  }
}
