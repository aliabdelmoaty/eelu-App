// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/core/utils/notifications.dart';
import 'package:payment/features/home/presentation/data/model/item_course_model.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit() : super(CourseInitial());
  static CourseCubit get(context) => BlocProvider.of(context);
  List<VideoStreamInfo> videoQualities = [];
  List<String> sizes = [];
  ItemCourseModel? items;
  final Dio _dio = Dio();
  final _yt = YoutubeExplode();
  String? downloadProgress;
  String path = '';
  String? nameVideo;
  String? namePdf;
  String? directoryPath;
  List<String>? pathPdf;
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
        sizes = await Future.wait(videoQualities.map((stream) async {
          return await sizeOfFile(url: stream.url.toString());
        }));
      }
      emit(AnalyzeVideoSuccess());
    } catch (e) {
      print(e.toString());
      emit(AnalyzeVideoError(
          e: "Please enter a working url \n ${e.toString().substring(0, 60)} "));
    }
  }

  Future<bool> requestStoragePermissions() async {
    await Permission.storage.request();
    await Permission.accessMediaLocation.request();
    await Permission.mediaLibrary.request();
    await Permission.manageExternalStorage.request();
    var isIos = Platform.isIOS;
    if (isIos) await Permission.photos.request();
    var storageIsGranted = await Permission.storage.isGranted;
    var accessMediaLocationIsGranted =
        await Permission.accessMediaLocation.isGranted;
    var mediaLibraryIsGranted = await Permission.mediaLibrary.isGranted;
    var manageExternalStorageIsGranted =
        await Permission.manageExternalStorage.isGranted;
    var photos = isIos ? await Permission.photos.isGranted : true;

    var isGranted = storageIsGranted &&
        accessMediaLocationIsGranted &&
        mediaLibraryIsGranted &&
        manageExternalStorageIsGranted &&
        photos;
    return isGranted;
  }

  Future<void> getLocation() async {
    try {
      emit(GetLocationLoading());
      await requestStoragePermissions();
      var baseDirectory = '/storage/emulated/0/download/';
      var eduproDirectory = Directory('$baseDirectory/edupro');
      if (!eduproDirectory.existsSync()) {
        eduproDirectory.createSync(recursive: true);
      }
      directoryPath = eduproDirectory.path;
      print('directoryPath is: $directoryPath');
      emit(GetLocationSuccess());
    } catch (e) {
      emit(GetLocationError(e: "Error getting location: $e"));
    }
  }

  Future<String> sizeOfFile({required String url}) async {
    try {
      Dio dio = Dio();

      Response response = await dio.head(url);

      if (response.statusCode == 200) {
        int contentLength = int.parse(response.headers['content-length']![0]);

        return _formatFileSize(contentLength);
      } else {
        throw Exception(
            'Failed to retrieve file metadata: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      return 'Unknown';
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    } else if (bytes < 1024 * 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024 * 1024)).toStringAsFixed(2)} TB';
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
              onReceiveProgress: (received, total) {
            if (total <= 0) return;
            downloadProgress =
                '${(received / total * 100).toStringAsFixed(0)}%';
            _localNotificationService
                .showDownloadProgressNotification(downloadProgress!);

            emit(DownloadVideoProcess(progress: downloadProgress!));
          });

          emit(DownloadVideoSuccess());
          _localNotificationService.showDownloadSuccessNotification(nameVideo!);
        } on DioException catch (e) {
          print(e.toString());
          emit(DownloadVideoError(e: 'Error in download video${e.message}'));
        } on PathAccessException catch (e) {
          emit(DownloadVideoError(
              e: 'Error in access save file video ${e.message}'));
        }
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
        emit(DownloadPdfSuccess());
        _localNotificationService.showDownloadSuccessNotification(namePdf!);
      } catch (e) {
        print(e.toString());
        emit(DownloadPdfError(e: e.toString()));
      }
    }
  }

  Future<void> add(
      {String? title,
      String? url,
      String? nameCourse,
      String? nameUpdate}) async {
    emit(AddLoading());
    try {
      await FirebaseFirestore.instance
          .collection('courses')
          .doc('$nameCourse')
          .update({
        '$nameUpdate.$title': url,
      });
      _localNotificationService.showNotification(
          'Add Success', 'Add $title successfully');
      emit(AddSuccess());
    } catch (e) {
      emit(AddError(e: e.toString()));
    }
  }

  Future<void> delete(
      {String? title,
      String? nameCourse,
      String? nameDelete,
      bool? pdf = false}) async {
    emit(DeleteLoading());
    try {
      await FirebaseFirestore.instance
          .collection('courses')
          .doc('$nameCourse')
          .update({
        '$nameDelete.$title': FieldValue.delete(),
      });
      if (pdf == true) {
        await FirebaseStorage.instance
            .ref()
            .child('/material/$nameCourse/$title.pdf')
            .delete();
      }
      _localNotificationService.showNotification(
          'Delete Success', 'Delete $title successfully');
      emit(DeleteSuccess());
    } catch (e) {
      emit(DeleteError(e: e.toString()));
    }
  }

  Future<void> chooseFile() async {
    emit(ChooseFileLoading());
    try {
      final filePicker = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
          allowMultiple: true);
      if (filePicker != null) {
        pathPdf = [];
        for (var file in filePicker.files) {
          print(file.path);
          pathPdf?.add(file.path!);
        }
        print('pathPdf is:  $pathPdf');
        emit(ChooseFileSuccess());
      } else {
        emit(ChooseFileError(e: 'No file selected'));
      }
    } catch (e) {
      print(e.toString());
      emit(ChooseFileError(e: e.toString()));
    }
  }

  Future<void> uploadFile({String? nameCourse}) async {
    try {
      emit(UploadFileLoading());
      for (String path in pathPdf!) {
        await FirebaseStorage.instance
            .ref()
            .child('/material/$nameCourse/${Uri.file(path).pathSegments.last}')
            .putFile(File(path))
            .then((p0) => p0.ref.getDownloadURL().then((url) {
                  List<String> pathComponents =
                      Uri.file(path).pathSegments.last.split('/');
                  String fileNameWithExtension = pathComponents.last;
                  String nameWithoutExtension =
                      fileNameWithExtension.replaceAll('.pdf', '');
                  add(
                      title: nameWithoutExtension,
                      url: url,
                      nameCourse: nameCourse,
                      nameUpdate: 'lectures');
                }));
      }

      emit(UploadFileSuccess());
    } catch (e) {
      emit(UploadFileError(e: e.toString()));
    }
  }

  Future<void> getDataCourses({required String nameCourse}) async {
    try {
      emit(UpdateDataCoursesLoading());

      FirebaseFirestore.instance
          .collection('courses')
          .doc(nameCourse)
          .snapshots()
          .listen((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          final Map<String, dynamic>? data =
              snapshot.data() as Map<String, dynamic>?;
          items = ItemCourseModel.fromJson({
            'image': data?['image'],
            'lectures': Map<String, String>.from(data?['lectures'] ?? {}),
            'videos': Map<String, String>.from(data?['videos'] ?? {}),
            'doctors': List<String>.from(data?['doctors'] ?? []),
          });
          emit(UpdateDataCoursesSuccess());
        } else {
          // If the document does not exist, emit an error state
          emit(UpdateDataCoursesError(e: "Document does not exist"));
        }
      });
    } catch (e) {
      emit(UpdateDataCoursesError(e: e.toString()));
    }
  }
}
