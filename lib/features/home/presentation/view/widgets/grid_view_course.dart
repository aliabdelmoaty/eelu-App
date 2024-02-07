import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/app_router.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/features/home/presentation/data/model/item_course_model.dart';
import 'package:payment/features/home/presentation/view/widgets/course_item.dart';

class GridViewCourse extends StatelessWidget {
  const GridViewCourse({
    super.key,
    required this.courses,
    required this.dataCourse,
  });
  final List<String> courses;
  final List<ItemCourseModel> dataCourse;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 530.h,
      child: GridView.count(
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 20.0,
        shrinkWrap: true,
        children: List.generate(courses.length, (index) {
          return GestureDetector(
            onTap: () {
              _showDoctorDialog(
                  context, dataCourse[index].doctors, courses[index],dataCourse[index]);

              // ignore: avoid_print
              print(index);
            },
            child: CourseItem(
              courseName: courses[index],
              image: dataCourse[index].image,
            ),
          );
        }),
      ),
    );
  }
}

void _showDoctorDialog(
    BuildContext context, List<String>? doctorsName, String name, ItemCourseModel itemCourse) {

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Choose a Doctor',
          style: Styles.textStyle16,
        ),
        content: SizedBox(
          height: 175.h,
          child: Column(
            children: <Widget>[
              for (String doctor in doctorsName!)
                ListTile(
                  title: Text(
                    doctor,
                    style: Styles.textStyle13,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    GoRouter.of(context).push(AppRouter.course, extra: {
                      'title': name,
                      'itemCourseModel': itemCourse
                    });
                  },
                ),
            ],
          ),
        ),
      );
    },
  ).then((value) {
    if (value != null) {
      GoRouter.of(context).push(AppRouter.course);
    }
  });
}
