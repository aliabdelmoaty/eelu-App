import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/core/utils/assets.dart';
import 'package:payment/core/utils/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeScreenBody(),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Hi, ALEX', style: Styles.textStyle24),
                const Spacer(),
                CircleAvatar(
                  radius: 22.r,
                  backgroundImage: const AssetImage(Assets.imagesSplash),
                )
              ],
            ),
            SizedBox(height: 5.h),
            const Text('What Would you like to learn Today? ',
                style: Styles.textStyle70013),
            SizedBox(height: 20.h),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                children: List.generate(6, (index) {
                  return GestureDetector(
                    onTap: () {
                      // ignore: avoid_print
                      print(index);
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 190.w,
                          height: 165.h,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x14000000),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 190.w,
                          height: 120.h,
                          decoration: const ShapeDecoration(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 125.h,
                          left: 10.w,
                          child: const Text('Data Structure',
                              style: Styles.textStyle16),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
