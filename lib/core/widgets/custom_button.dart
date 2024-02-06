import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payment/core/utils/colors.dart';
import 'package:payment/core/utils/styles.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
  });
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              shadowColor: MaterialStateColor.resolveWith(
                  (states) => const Color(0x4C000000)),
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => ColorsApp.blue)),
          onPressed: onPressed,
          child: Row(
            children: [
              Text(
                text,
                style: Styles.textStyle18,
              ),
              const Spacer(),
              Container(
                width: 41.w,
                height: 41.h,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(),
                ),
                child: const Icon(
                  Icons.arrow_forward_outlined,
                  color: ColorsApp.blue,
                ),
              ),
            ],
          )),
    );
  }
}

