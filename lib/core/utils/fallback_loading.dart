import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/core/utils/colors.dart';

class FallbackLoading extends StatelessWidget {
  const FallbackLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 50.h,
          width: 50.h,
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
            color: ColorsApp.blue,
          ),
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )),
    );
  }
}
