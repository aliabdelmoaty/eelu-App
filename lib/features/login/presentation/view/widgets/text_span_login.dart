import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/app_router.dart';
import 'package:payment/core/utils/styles.dart';

class TextSpanLogin extends StatelessWidget {
  const TextSpanLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      const TextSpan(
        text: 'Don’t have an Account? ',
        style: Styles.textStyle70014,
      ),
      TextSpan(
          text: 'SIGN UP',
          style: Styles.textStyle80014,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              GoRouter.of(context).push(AppRouter.register);
            })
    ]));
  }
}
