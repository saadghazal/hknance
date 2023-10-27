part of 'community_cubit.dart';

class CommunityState extends Equatable {
  final LoadingStatus loadingStatus;
  final LoadingStatus getUserPostsLoading;
  final ErrorHandler errorHandler;
  final List<PostModel> communityPosts;
  final List<PostModel> userPosts;

  final LoadingStatus addCommentStatus;

  const CommunityState({
    required this.errorHandler,
    required this.loadingStatus,
    required this.userPosts,
    required this.communityPosts,
    required this.getUserPostsLoading,
    required this.addCommentStatus,
  });

  factory CommunityState.initial() {
    return CommunityState(
      errorHandler: ErrorHandler.noError(),
      loadingStatus: LoadingStatus.initial,
      userPosts: [],
      communityPosts: [],
      getUserPostsLoading: LoadingStatus.initial,
      addCommentStatus: LoadingStatus.initial,
    );
  }

  @override
  List<Object> get props => [
        loadingStatus,
        errorHandler,
        userPosts,
        communityPosts,
        getUserPostsLoading,
        addCommentStatus,
      ];

  CommunityState copyWith({
    LoadingStatus? loadingStatus,
    LoadingStatus? getUserPostsLoading,
    ErrorHandler? errorHandler,
    List<PostModel>? communityPosts,
    List<PostModel>? userPosts,
    LoadingStatus? addCommentStatus,
  }) {
    return CommunityState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      getUserPostsLoading: getUserPostsLoading ?? this.getUserPostsLoading,
      errorHandler: errorHandler ?? this.errorHandler,
      communityPosts: communityPosts ?? this.communityPosts,
      userPosts: userPosts ?? this.userPosts,
      addCommentStatus: addCommentStatus ?? this.addCommentStatus,
    );
  }
}
