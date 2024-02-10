import 'package:flutter/material.dart';

import 'package:payment/features/course/presentation/view/widgets/course_screen_body.dart';
import 'package:payment/features/home/presentation/data/model/item_course_model.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen(
      {super.key, required this.title, required this.itemCourseModel});
  final String title;
  final ItemCourseModel itemCourseModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CourseScreenBody(
        itemsVideo: itemCourseModel.videos,
        itemLec: itemCourseModel.lectures,
        nameCourse: title,
      ),
    );
  }
}


