import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/constant.dart';
import 'package:payment/core/utils/app_router.dart';
import 'package:payment/features/register/model/register_model.dart';

class CircleAvatarProfile extends StatelessWidget {
  
  const CircleAvatarProfile({
    super.key, required this.userData,
  });
  final RegisterModel? userData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.profile,extra:userData);
      },
      child: CircleAvatar(
        radius: 22.r,
        backgroundImage:  NetworkImage(userData?.image?? image),
      ),
    );
  }
}
