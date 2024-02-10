part of 'register_cubit.dart';

@immutable
 class RegisterState {}

 class RegisterInitial extends RegisterState {}
 class RegisterLoading extends RegisterState {}
 class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}
 class RegisterSuccess extends RegisterState {
  final String uid;
  RegisterSuccess(this.uid);
 }
 class CreateUserLoading extends RegisterState {}
 class CreateUserSuccess extends RegisterState {}
 class CreateUserError extends RegisterState {}
 class ChangePasswordVisibility extends RegisterState {}



