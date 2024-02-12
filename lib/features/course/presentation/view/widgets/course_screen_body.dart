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
    this.nameCourse,
  });

  final String? nameCourse;
  @override
  Widget build(BuildContext context) {
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
                          onPressed: () async {
                            bool status = await CourseCubit.get(context)
                                .requestStoragePermissions();
                            if (status == false) {
                              openAppSettings();
                            }
                            GoRouter.of(context).pop();
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
                              bool status = await CourseCubit.get(context)
                                  .requestStoragePermissions();
                              if (status == false) {
                                openAppSettings();
                              }
                              GoRouter.of(context).pop();
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
                    items: cubit.items?.lectures.keys.toList() ?? [],
                    text: 'Lectures',
                    url: cubit.items?.lectures.values.toList() ?? [],
                    title: cubit.items?.lectures.keys.toList() ?? [],
                    nameCourse: nameCourse,
                    cubit: cubit,
                    onTap: () {
                      cubit.chooseFile().then(
                          (value) => cubit.uploadFile(nameCourse: nameCourse));
                    }),
                const SizedBox(height: 20),
                CustomExpansionTile(
                  items: cubit.items?.videos.keys.toList() ?? [],
                  url: cubit.items?.videos.values.toList() ?? [],
                  title: cubit.items?.videos.keys.toList() ?? [],
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
