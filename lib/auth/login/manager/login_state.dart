part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String error;
  LoginError({required this.error});
}
class ShowPasswordInLogin extends LoginState {}
