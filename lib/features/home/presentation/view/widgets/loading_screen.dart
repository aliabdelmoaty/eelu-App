import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 200.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    width: 200.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.white,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          GridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 20.0,
              shrinkWrap: true,
              children: List.generate(6, (index) {
                return Column(
                  children: [
                    Container(
                      width: 200.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      width: 200.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }))
        ]),
      ),
    );
  }
}
