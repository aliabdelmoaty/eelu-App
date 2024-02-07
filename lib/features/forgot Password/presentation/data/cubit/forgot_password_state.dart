part of 'forgot_password_cubit.dart';


 class ForgotPasswordState {}

 class ForgotPasswordInitial extends ForgotPasswordState {}
 class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;
  ForgotPasswordSuccess(this.message);
}
 class ForgotPasswordError extends ForgotPasswordState {
  final String message;
  ForgotPasswordError(this.message);
}
 class ForgotPasswordLoading extends ForgotPasswordState {}

