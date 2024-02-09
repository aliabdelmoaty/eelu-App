part of 'login_cubit.dart';

class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String uidUser;
  LoginSuccess(this.uidUser);
}

class SaveUidSuccess extends LoginState {}

class SaveUidError extends LoginState {}

class ChangePasswordVisibility extends LoginState {}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
