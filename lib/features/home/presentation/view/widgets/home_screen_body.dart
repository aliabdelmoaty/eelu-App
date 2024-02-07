import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/core/widgets/circle_avatar_profile.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/features/home/presentation/data/cubit/home_cubit.dart';
import 'package:payment/features/home/presentation/view/widgets/grid_view_course.dart';
import 'package:payment/features/home/presentation/view/widgets/loading_screen.dart';

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
              if (state is GetDataCoursesSuccess ||
                  state is GetCoursesSuccess ||
                  state is GetUserDataSuccess) {
                var cubit = HomeCubit.get(context);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Hi, ${cubit.userModel?.name}',
                            style: Styles.textStyle24),
                        const Spacer(),
                        CircleAvatarProfile(
                          userData: cubit.userModel!,
                        )
                      ],
                    ),
                    SizedBox(height: 5.h),
                    const Text('What Would you like to learn Today? ',
                        style: Styles.textStyle70013),
                    SizedBox(height: 20.h),
                    GridViewCourse(
                      courses: cubit.coursesName!,
                      dataCourse: cubit.itemCourseModel!,
                    ),
                  ],
                );
              } else {
                return const LoadingScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
