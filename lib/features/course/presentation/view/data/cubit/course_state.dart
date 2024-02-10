part of 'course_cubit.dart';

class CourseState {}

class CourseInitial extends CourseState {}

class AnalyzeVideoLoading extends CourseState {}

class AnalyzeVideoSuccess extends CourseState {}

class AnalyzeVideoError extends CourseState {
  String e;
  AnalyzeVideoError({required this.e});
}

class DownloadVideoLoading extends CourseState {}

class DownloadVideoSuccess extends CourseState {}

class DownloadVideoProcess extends CourseState {
  String progress;
  DownloadVideoProcess({required this.progress});
}

class DownloadVideoError extends CourseState {
  String e;
  DownloadVideoError({required this.e});
}

class DownloadPdfLoading extends CourseState {}

class DownloadPdfSuccess extends CourseState {}

class DownloadPdfProcess extends CourseState {
  String progress;

  DownloadPdfProcess({required this.progress});
}

class DownloadPdfError extends CourseState {
  String e;
  DownloadPdfError({required this.e});
}

class GetLocationLoading extends CourseState {}

class GetLocationSuccess extends CourseState {}

class GetLocationError extends CourseState {
  String e;
  GetLocationError({required this.e});
}

class AddLoading extends CourseState {}

class AddError extends CourseState {
  final String e;

  AddError({required this.e});
}

class AddSuccess extends CourseState {}

class ChooseFileLoading extends CourseState {}

class ChooseFileSuccess extends CourseState {}

class ChooseFileError extends CourseState {
  final String e;
  ChooseFileError({required this.e});
}

class UploadFileSuccess extends CourseState {}

class UploadFileError extends CourseState {
  final String e;
  UploadFileError({required this.e});
}

class UploadFileLoading extends CourseState {}

class DeleteLoading extends CourseState {}

class DeleteError extends CourseState {
  final String e;

  DeleteError({required this.e});
}

class DeleteSuccess extends CourseState {}
