import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/app_router.dart';
import 'package:payment/core/utils/assets.dart';
import 'package:payment/core/utils/colors.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/features/profile/presentation/data/cubit/profile_cubit.dart';
import 'package:payment/features/register/model/register_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userData});
  final RegisterModel userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ProfileScreenBody(
        userData: userData,
      ),
    );
  }
}

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key, required this.userData});
  final RegisterModel userData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0.r),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 68.r,
                backgroundColor: ColorsApp.blue,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 65.r,
                  backgroundImage: NetworkImage(userData.image),
                ),
              ),
              SizedBox(height: 4.h),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      RowInfo(
                          assetImage: Assets.imagesName, text: userData.name),
                      SizedBox(
                        height: 10.h,
                      ),
                      RowInfo(
                          assetImage: Assets.imagesEmail, text: userData.email),
                      SizedBox(
                        height: 10.h,
                      ),
                      RowInfo(
                          assetImage: Assets.imagesId,
                          text: userData.id.toString()),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => ColorsApp.blue)),
                  onPressed: () {
                    ProfileCubit.get(context).logOut().then((value) {
                      GoRouter.of(context).go(AppRouter.login);
                    });
                  },
                  child: const Text(
                    'SIGN OUT',
                    style: Styles.textStyle18,
                  )),
            ],
          );
        },
      ),
    );
  }
}

class RowInfo extends StatelessWidget {
  const RowInfo({
    super.key,
    required this.assetImage,
    required this.text,
  });
  final String assetImage;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0.r),
          child: SvgPicture.asset(
            assetImage,
          ),
        ),
        Text(
          text,
          style: Styles.textStyle70014.copyWith(fontSize: 14.sp),
        ),
      ],
    );
  }
}
