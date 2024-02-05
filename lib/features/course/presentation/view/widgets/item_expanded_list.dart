import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/app_router.dart';
import 'package:payment/core/utils/styles.dart';

class ItemExpandedList extends StatelessWidget {
  const ItemExpandedList({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: Styles.textStyle16,
        ),
        const Spacer(),
        GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppRouter.login);
            },
            child: Icon(
              Icons.visibility_outlined,
              size: 24.r,
            )),
        SizedBox(width: 10.w),
        GestureDetector(
            onTap: () {
              print('object');
            },
            child: Icon(
              Icons.file_download_outlined,
              size: 24.r,
            )),
      ],
    );
  }
}
