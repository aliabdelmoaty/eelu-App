import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/core/widgets/custom_expansion_tile.dart';

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
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomExpansionTile(
              items: ['Lec 1', 'Lec 2'],
              text: 'Lectures',
            ),
            SizedBox(height: 20),
            CustomExpansionTile(
              items: [
                'Video 1',
                'Video 2',
                'Video 1',
                'Video 2',
                'Video 1',
                'Video 2'
              ],
              text: 'Videos',
            ),
          ],
        ),
      ),
    );
  }
}
