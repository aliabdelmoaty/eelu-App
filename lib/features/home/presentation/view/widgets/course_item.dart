import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/core/utils/styles.dart';

class CourseItem extends StatelessWidget {
  const CourseItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 170.w,
          height: 165.h,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
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
          width: 170.w,
          height: 110.h,
          decoration: ShapeDecoration(
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
          ),
        ),
        Positioned(
          top: 115.h,
          left: 10.w,
          child: SizedBox(
            width: 160.w,
            child: const Text('Introduction to Operation Research',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Styles.textStyle16),
          ),
        ),
      ],
    );
  }
}
