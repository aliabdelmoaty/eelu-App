import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/app_router.dart';
import 'package:payment/core/utils/styles.dart';

class RowRememberAndForgot extends StatelessWidget {
  const RowRememberAndForgot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       
        const Spacer(),
        TextButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.forgot);
          },
          child: const Text(
            'Forgot Password?',
            style: Styles.textStyle13,
          ),
        ),
      ],
    );
  }
}
