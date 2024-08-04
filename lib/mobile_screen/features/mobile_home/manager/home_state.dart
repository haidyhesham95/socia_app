part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class CommentUploading extends HomeState {}

class CommentUploaded extends HomeState {}

class CommentUploadError extends HomeState {
  final String error;

  CommentUploadError(this.error);
}

class UserProfileLoaded extends HomeState {
  final Map<String, dynamic> profileData;

  UserProfileLoaded(this.profileData);
}

class UserProfileError extends HomeState {
  final String error;

  UserProfileError(this.error);
}


class PostDeleted extends HomeState {}

class PostError extends HomeState {
  final String error;

  PostError(this.error);
}

class PostUnliked extends HomeState {}

class PostLiked extends HomeState {}

class ErrorLike extends HomeState {
  final String error;

  ErrorLike(this.error);
}

class PostSaved extends HomeState {}

class PostUnsaved extends HomeState {}

class ErrorSave extends HomeState {
  final String error;

  ErrorSave(this.error);
}

class LikeAnimationState extends HomeState {
  final bool isLiked;

  LikeAnimationState(this.isLiked);
}

class SavedPostsLoading extends HomeState {}

class SavedPostsLoaded extends HomeState {
  final List<Map<String, dynamic>> savedPosts;

  SavedPostsLoaded(this.savedPosts);
}
