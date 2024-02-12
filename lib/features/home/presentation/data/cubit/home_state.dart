part of 'home_cubit.dart';

 class HomeState {}

 class HomeInitial extends HomeState {}
 class GetCoursesLoading extends HomeState {}
 class GetCoursesSuccess extends HomeState {}
 class GetCoursesError extends HomeState {
  final String e;

  GetCoursesError({required this.e});
}
 class GetDataCoursesLoading extends HomeState {}

 class GetDataCoursesSuccess extends HomeState {}

 class GetDataCoursesError extends HomeState {
  final String e;

  GetDataCoursesError({required this.e});
}

 class GetUserDataLoading extends HomeState {}

 class GetUserDataSuccess extends HomeState {}

 class GetUserDataError extends HomeState {
  final String e;

  GetUserDataError({required this.e});
}

class GetAllDataLoading extends HomeState{}
class GetAllDataSuccess extends HomeState {}
class GetAllDataError extends HomeState {}

