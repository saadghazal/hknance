part of 'community_cubit.dart';

class CommunityState extends Equatable {
  final LoadingStatus loadingStatus;
  final LoadingStatus getUserPostsLoading;
  final ErrorHandler errorHandler;
  final List<PostModel> communityPosts;
  final List<PostModel> userPosts;

  const CommunityState({
    required this.errorHandler,
    required this.loadingStatus,
    required this.userPosts,
    required this.communityPosts,
    required this.getUserPostsLoading,
  });

  factory CommunityState.initial() {
    return CommunityState(
      errorHandler: ErrorHandler.noError(),
      loadingStatus: LoadingStatus.initial,
      userPosts: [],
      communityPosts: [],
      getUserPostsLoading: LoadingStatus.initial,
    );
  }

  @override
  List<Object> get props => [loadingStatus, errorHandler,userPosts,communityPosts,getUserPostsLoading,];

  CommunityState copyWith({
    LoadingStatus? loadingStatus,
    LoadingStatus? getUserPostsLoading,
    ErrorHandler? errorHandler,
    List<PostModel>? communityPosts,
    List<PostModel>? userPosts,
  }) {
    return CommunityState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      getUserPostsLoading: getUserPostsLoading ?? this.getUserPostsLoading,
      errorHandler: errorHandler ?? this.errorHandler,
      communityPosts: communityPosts ?? this.communityPosts,
      userPosts: userPosts ?? this.userPosts,
    );
  }
}
