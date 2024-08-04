part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {}

final class ProfileError extends ProfileState {
  final String error;
  ProfileError({required this.error});
}

final class ChangeShowFollowState extends ProfileState {
  final bool showFollow;
  ChangeShowFollowState({required this.showFollow});
}

final class SignOutLoading extends ProfileState {}
final class SignOutSuccess extends ProfileState {}

final class SignOutError extends ProfileState {
  final String error;
  SignOutError({required this.error});
}

final class PickImageSuccess extends ProfileState {
  final Uint8List imgPath;
  final String imgName;
  PickImageSuccess({required this.imgPath, required this.imgName});
}

final class ChangeInformation extends ProfileState {

}

final class ImageLoading extends ProfileState {}