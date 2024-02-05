import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/features/course/presentation/view/widgets/expandable_list_lec.dart';
import 'package:payment/features/course/presentation/view/widgets/expandable_list_video.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Introduction to Operation Research'),
      ),
      body: const CourseScreenBody(
        isExpanded: false,
      ),
    );
  }
}

class CourseScreenBody extends StatelessWidget {
  const CourseScreenBody({super.key, required this.isExpanded});
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: isExpanded ? 600.h : 50.h,
                child: ExpandableListLec(
                  isExpandedLec: isExpanded,
                )),
            // const SizedBox(height: 20),
            SizedBox(height: 600.h, child: const ExpandableListVideos()),
          ],
        ),
      ),
    );
  }
}
