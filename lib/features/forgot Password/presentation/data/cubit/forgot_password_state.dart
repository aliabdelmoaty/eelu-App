part of 'forgot_password_cubit.dart';


sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}
final class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;
  ForgotPasswordSuccess(this.message);
}
final class ForgotPasswordError extends ForgotPasswordState {
  final String message;
  ForgotPasswordError(this.message);
}
final class ForgotPasswordLoading extends ForgotPasswordState {}

