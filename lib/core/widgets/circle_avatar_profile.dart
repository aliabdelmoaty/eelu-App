import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/app_router.dart';
import 'package:payment/core/utils/assets.dart';

class CircleAvatarProfile extends StatelessWidget {
  const CircleAvatarProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.profile);
      },
      child: CircleAvatar(
        radius: 22.r,
        backgroundImage: const AssetImage(Assets.imagesSplash),
      ),
    );
  }
}
