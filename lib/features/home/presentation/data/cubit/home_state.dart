part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class GetCoursesLoading extends HomeState {}
final class GetCoursesSuccess extends HomeState {}
final class GetCoursesError extends HomeState {
  final String e;

  GetCoursesError({required this.e});
}
final class GetDataCoursesLoading extends HomeState {}

final class GetDataCoursesSuccess extends HomeState {}

final class GetDataCoursesError extends HomeState {
  final String e;

  GetDataCoursesError({required this.e});
}


