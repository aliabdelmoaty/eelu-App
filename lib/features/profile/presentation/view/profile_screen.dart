import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:payment/core/utils/assets.dart';
import 'package:payment/core/utils/colors.dart';
import 'package:payment/core/utils/styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const ProfileScreenBody(),
    );
  }
}

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 68.r,
            backgroundColor: ColorsApp.blue,
            child: CircleAvatar(
              radius: 65.r,
              backgroundImage: const AssetImage(Assets.imagesSplash),
            ),
          ),
          SizedBox(height: 4.h),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const RowInfo(
                      assetImage: Assets.imagesName, text: 'Ali Mohamed'),
                  SizedBox(
                    height: 10.h,
                  ),
                  const RowInfo(
                      assetImage: Assets.imagesEmail,
                      text: 'abdelmoaty841@gmail.com'),
                  SizedBox(
                    height: 10.h,
                  ),
                  const RowInfo(assetImage: Assets.imagesId, text: '2200818'),
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
              onPressed: () {},
              child: const Text(
                'SIGN OUT',
                style: Styles.textStyle18,
              )),
        ],
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
