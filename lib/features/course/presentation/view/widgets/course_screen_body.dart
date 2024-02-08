import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/widgets/custom_expansion_tile.dart';
import 'package:payment/features/course/presentation/view/data/cubit/course_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

class CourseScreenBody extends StatelessWidget {
  const CourseScreenBody({
    super.key,
    required this.itemsVideo,
    required this.itemLec,
  });
  final Map<String, dynamic> itemsVideo;
  final Map<String, dynamic> itemLec;

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
                    title:
                        const Text('we need permission to access the storage'),
                    content: Text(state.e),
                    actions: [
                      TextButton(
                          onPressed: () {
                            openAppSettings();
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
                    title:
                        const Text('Failed to download the video, try again'),
                    content: Text(state.e),
                    actions: [
                      TextButton(
                          onPressed: () {
                            GoRouter.of(context).pop();
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
                    cubit: cubit),
                const SizedBox(height: 20),
                CustomExpansionTile(
                    items: nameVideos,
                    url: urlVideos,
                    title: nameVideos,
                    text: 'Videos',
                    cubit: cubit)
              ],
            );
          },
        ),
      ),
    );
  }
}
