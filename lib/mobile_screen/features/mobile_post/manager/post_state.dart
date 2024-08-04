part of 'post_cubit.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

final class PostLoading extends PostState {}

final class PostSuccess extends PostState {}

class PostError extends PostState {
  final String error;
  PostError(this.error);
}

class PostImagePicked extends PostState {
  final Uint8List imgPath;
  PostImagePicked(this.imgPath);
}

final class ProfileLoading extends PostState {}

final class ProfileSuccess extends PostState {}

final class ProfileError extends PostState {
  final String error;
  ProfileError({required this.error});
}