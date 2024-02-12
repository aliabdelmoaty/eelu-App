import 'package:flutter/material.dart';
import 'package:payment/features/course/presentation/view/data/cubit/course_cubit.dart';

import 'package:payment/features/course/presentation/view/widgets/course_screen_body.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    CourseCubit.get(context).getDataCourses(nameCourse: title);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CourseScreenBody(
        nameCourse: title,
      ),
    );
  }
}
