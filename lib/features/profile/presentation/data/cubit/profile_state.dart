part of 'profile_cubit.dart';

 class ProfileState {}

 class ProfileInitial extends ProfileState {}
 class ProfileLoading extends ProfileState {}
 class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
 class ProfileSuccess extends ProfileState {}

