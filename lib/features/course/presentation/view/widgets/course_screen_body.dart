import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/widgets/custom_expansion_tile.dart';
import 'package:payment/features/course/presentation/view/data/cubit/course_cubit.dart';
import 'package:payment/features/course/presentation/view/widgets/add_video.dart';
import 'package:permission_handler/permission_handler.dart';

class CourseScreenBody extends StatelessWidget {
  const CourseScreenBody({
    super.key,
    required this.itemsVideo,
    required this.itemLec,
    this.nameCourse,
  });
  final Map<String, dynamic> itemsVideo;
  final Map<String, dynamic> itemLec;
  final String? nameCourse;
  @override
  Widget build(BuildContext context) {
    List<String> nameVideos = [];
    List<String> urlVideos = [];
    List<String> nameLectures = [];
    List<String> urlLectures = [];
    itemsVideo.forEach((key, value) {
      nameVideos.add(key);
      urlVideos.add(value);
    });
    itemLec.forEach((key, value) {
      nameLectures.add(key);
      urlLectures.add(value);
    });
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: BlocConsumer<CourseCubit, CourseState>(
          listener: (context, state) {
            if (state is GetLocationError) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: state.e ==
                            'Please allow the permission to access the storage'
                        ? const Text('we need permission to access the storage')
                        : Text("No directory selected"),
                    content: Text(state.e),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Permission.manageExternalStorage.request();
                          },
                          child: const Text('Open Settings'))
                    ],
                  );
                },
              );
            }
            if (state is DownloadVideoError) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Failed to download the video'),
                    content: Text(state.e),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            if (state.e.startsWith('Error in access')) {
                              var status = await Permission
                                  .manageExternalStorage
                                  .request();
                              if (status.isDenied) {
                                openAppSettings().then((value) {
                                  GoRouter.of(context).pop();
                                });
                              }
                            } else {
                              GoRouter.of(context).pop();
                            }
                          },
                          child: const Text('ok'))
                    ],
                  );
                },
              );
            }
            
            if (state is AnalyzeVideoLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const AlertDialog(
                    title: Text('Analyzing...'),
                  );
                },
              );
            } else if (state is AnalyzeVideoSuccess) {
              GoRouter.of(context).pop();
            }
            if (state is AddSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('added successfully'),
                ),
              );
            }
            if (state is AddError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.e),
                ),
              );
            }
          },
          builder: (context, state) {
            var cubit = CourseCubit.get(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomExpansionTile(
                    items: nameLectures,
                    text: 'Lectures',
                    url: urlLectures,
                    title: nameLectures,
                    nameCourse: nameCourse,
                    cubit: cubit,
                    onTap: () {
                      cubit.chooseFile().then(
                          (value) => cubit.uploadFile(nameCourse: nameCourse));
                    }),
                const SizedBox(height: 20),
                CustomExpansionTile(
                  items: nameVideos,
                  url: urlVideos,
                  title: nameVideos,
                  text: 'Videos',
                  cubit: cubit,
                  nameCourse: nameCourse,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AddVideo(
                          cubit: cubit,
                          nameCourse: nameCourse,
                        );
                      },
                    );
                  },
                ),
                
              ],
            );
          },
        ),
      ),
    );
  }
}
