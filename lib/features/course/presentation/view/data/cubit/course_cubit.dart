// ignore_for_file: avoid_print

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/core/utils/notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit() : super(CourseInitial());
  static CourseCubit get(context) => BlocProvider.of(context);
  List<VideoStreamInfo> videoQualities = [];
  final Dio _dio = Dio();
  final _yt = YoutubeExplode();
  String? downloadProgress;
  String path = '';
  String? nameVideo;
  String? namePdf;
  String? directoryPath;
  final LocalNotificationService _localNotificationService =
      LocalNotificationService();
  Future<void> analyzeVideo({required String urlController}) async {
    emit(AnalyzeVideoLoading());
    String url = urlController;
    try {
      Video video = await _yt.videos.get(url);
      nameVideo = video.title;
      if (video.isLive) {
        _yt.videos.streamsClient.getHttpLiveStreamUrl(VideoId(url));
      } else {
        var value = await _yt.videos.streamsClient.getManifest(url);
        videoQualities = value.muxed.toList();
      }

      emit(AnalyzeVideoSuccess());
    } catch (e) {
      print(e.toString());
      emit(AnalyzeVideoError(
          e: "Please enter a working url \n ${e.toString().substring(0, 60)} "));
    }
  }

  Future<void> getLocation() async {
    try {
      emit(GetLocationLoading());
      var status = await Permission.storage.status;
      if (status.isDenied || status.isRestricted || status.isLimited) {
        DeviceInfoPlugin().androidInfo.then((value) {
          if (value.version.sdkInt < 33) {
            Permission.manageExternalStorage.request();
            emit(GetLocationError(
                e: "Please allow the permission to access the storage"));
          }
        });
      }
      try {
        directoryPath = await FilePicker.platform.getDirectoryPath();
        emit(GetLocationSuccess());
      } catch (e) {
        if (directoryPath == null) {
          emit(GetLocationError(e: "No directory selected"));
        }
      }
      print("Selected directory: $directoryPath");
    } catch (e) {
      print(e.toString());
      emit(GetLocationError(
          e: "Please allow the permission to access the storage"));
    }
  }

  Future<void> downloadVideo({
    required String urlController,
  }) async {
    await getLocation();
    emit(DownloadVideoLoading());
    if (directoryPath == null) {
      emit(DownloadVideoError(e: "No directory selected"));
      return;
    } else {
      try {
        var pathSave = '$directoryPath/$nameVideo.mp4';
        print(pathSave);
        try {
          await _dio.download(urlController, pathSave,
              // cancelToken: ,
              onReceiveProgress: (received, total) {
            if (total <= 0) return;
            downloadProgress =
                '${(received / total * 100).toStringAsFixed(0)}%';
            _localNotificationService
                .showDownloadProgressNotification(downloadProgress!);
            emit(DownloadVideoProcess(progress: downloadProgress!));
          });
        } catch (e) {
          print(e.toString());
          emit(DownloadVideoError(e: 'Error in download video${e.toString()}'));
        }
        _localNotificationService.showDownloadSuccessNotification(nameVideo!);
        emit(DownloadVideoSuccess());
      } catch (e) {
        print(e.toString());
        emit(DownloadVideoError(e: e.toString()));
      }
    }
  }

  Future<String> getPdfNameFromUrl(String pdfUrl) async {
    String decodedUrl = Uri.decodeFull(pdfUrl);
    List<String> parts = decodedUrl.split('/');
    String fileNameWithExtension = parts.last;
    namePdf = Uri.decodeFull(Uri.parse(fileNameWithExtension).path);

    namePdf = namePdf!.split('/').last.replaceAll('.pdf', '');

    return namePdf!;
  }

  Future<void> downloadPdf({
    required String urlController,
  }) async {
    await getLocation();
    emit(DownloadPdfLoading());
    if (directoryPath == null) {
      emit(DownloadVideoError(e: "No directory selected"));
      return;
    } else {
      try {
        var pathSave = '$directoryPath/$namePdf.pdf';
        print(pathSave);
        try {
          await _dio.download(urlController, pathSave,
              // cancelToken: ,
              onReceiveProgress: (received, total) {
            if (total <= 0) return;
            downloadProgress =
                '${(received / total * 100).toStringAsFixed(0)}%';
            _localNotificationService
                .showDownloadProgressNotification(downloadProgress!);
            emit(DownloadPdfProcess(progress: downloadProgress!));
          });
        } catch (e) {
          print(e.toString());
          emit(DownloadPdfError(e: 'Error in download pdf${e.toString()}'));
        }
        _localNotificationService.showDownloadSuccessNotification(namePdf!);
        emit(DownloadPdfSuccess());
      } catch (e) {
        print(e.toString());
        emit(DownloadPdfError(e: e.toString()));
      }
    }
  }
}
