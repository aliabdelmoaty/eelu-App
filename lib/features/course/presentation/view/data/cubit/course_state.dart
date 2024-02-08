part of 'course_cubit.dart';

sealed class CourseState {}

final class CourseInitial extends CourseState {}
final class AnalyzeVideoLoading extends CourseState {}
final class AnalyzeVideoSuccess extends CourseState {}
final class AnalyzeVideoError extends CourseState {
  final String e;
  AnalyzeVideoError({required this.e});
}
final class DownloadVideoLoading extends CourseState {}

final class DownloadVideoSuccess extends CourseState {}
final class DownloadVideoProcess extends CourseState {
  final String progress;
  DownloadVideoProcess({required this.progress});
}


final class DownloadVideoError extends CourseState {
  final String e;
  DownloadVideoError({required this.e});
}
final class DownloadPdfLoading extends CourseState {}

final class DownloadPdfSuccess extends CourseState {}

final class DownloadPdfProcess extends CourseState {
  final String progress;

  DownloadPdfProcess({required this.progress});
  
}

final class DownloadPdfError extends CourseState {
  final String e;
  DownloadPdfError({required this.e});
}

final class GetLocationLoading extends CourseState {}

final class GetLocationSuccess extends CourseState {}

final class GetLocationError extends CourseState {
  final String e;
  GetLocationError({required this.e});
}
