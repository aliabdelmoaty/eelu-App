import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/core/widgets/circle_avatar_profile.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/features/home/presentation/data/cubit/home_cubit.dart';
import 'package:payment/features/home/presentation/view/widgets/grid_view_course.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text('Hi, Ali', style: Styles.textStyle24),
                      Spacer(),
                      CircleAvatarProfile()
                    ],
                  ),
                  SizedBox(height: 5.h),
                  const Text('What Would you like to learn Today? ',
                      style: Styles.textStyle70013),
                  SizedBox(height: 20.h),
                  GridViewCourse(
                    courses: HomeCubit.get(context).coursesName!,
                    dataCourse: HomeCubit.get(context).itemCourseModel!,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
