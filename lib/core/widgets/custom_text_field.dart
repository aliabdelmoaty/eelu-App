import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payment/core/utils/colors.dart';
import 'package:payment/core/utils/styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
     this.assetName,
  });
  final String label;
  final String? hint;
  final String? assetName;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: Styles.textStyle70014,
        hintText: hint,
        prefixIcon:assetName != null? Padding(
          padding: EdgeInsets.all(12.0.r),
          child: SvgPicture.asset(
            assetName!,
          ),
        ):null,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorsApp.black19),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
      ),
    );
  }
}
