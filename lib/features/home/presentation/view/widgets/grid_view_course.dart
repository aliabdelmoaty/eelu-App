import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/app_router.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/features/home/presentation/view/widgets/course_item.dart';

class GridViewCourse extends StatelessWidget {
  const GridViewCourse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600.h,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        shrinkWrap: true,
        children: List.generate(6, (index) {
          return GestureDetector(
            onTap: () {
              _showDoctorDialog(context);

              // ignore: avoid_print
              print(index);
            },
            child: const CourseItem(),
          );
        }),
      ),
    );
  }
}


void _showDoctorDialog(BuildContext context) {
  List<String> doctors = [
    "Hanaa Abdelhady",
    "Safinaz AbdelFattah",
    "Yasser Abdelfattah",
    "Doctor 4",
  ];

  String selectedDoctor = doctors[0];

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
              for (String doctor in doctors)
                ListTile(
                  title: Text(
                    doctor,
                    style: Styles.textStyle13,
                  ),
                  onTap: () {
                    Navigator.pop(context, doctor);
                  },
                ),
            ],
          ),
        ),
      );
    },
  ).then((value) {
    if (value != null) {
      selectedDoctor = value;
      GoRouter.of(context).push(AppRouter.course);
    }
  });
}
