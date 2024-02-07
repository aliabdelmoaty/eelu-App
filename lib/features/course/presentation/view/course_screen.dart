import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/core/widgets/custom_expansion_tile.dart';
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
      ),
    );
  }
}

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
    List<String> nameVideos=[];
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
      child: Padding(
        padding: EdgeInsets.all(8.0.r),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomExpansionTile(
              items: nameLectures,
              text: 'Lectures',
              url: urlLectures,
              title: nameLectures,
            ),
            const SizedBox(height: 20),
            CustomExpansionTile(
              items:nameVideos,
              url: urlVideos,
              title: nameVideos,
              text: 'Videos',
            ),
          ],
        ),
      ),
    );
  }
}
