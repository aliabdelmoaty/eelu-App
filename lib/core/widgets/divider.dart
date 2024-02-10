import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/core/utils/colors.dart';

class DividerBottomSheet extends StatelessWidget {
  const DividerBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: ColorsApp.blue,
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
  }
}
