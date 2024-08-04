part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}



class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {
  final String error;

  RegisterError({required this.error});
}

class ImageLoading extends RegisterState {}


class ImagePicked extends RegisterState {

  ImagePicked();
}
class RegisterImagePicked extends RegisterState {
  Uint8List? image;

  RegisterImagePicked(this.image);
}
class RegisterUserDataFetched extends RegisterState {
  final UserModel registerModel;

  RegisterUserDataFetched(this.registerModel);
}
class ShowPasswordInSignUp extends RegisterState {}

