import 'package:flutter/material.dart';
import 'package:payment/core/utils/styles.dart';

class RowRememberAndForgot extends StatelessWidget {
  const RowRememberAndForgot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: (v) {},
          activeColor: const Color(0xff167F71),
          overlayColor: MaterialStateProperty.all(const Color(0xff167F71)),
          hoverColor: const Color(0xff167F71),
          checkColor: Colors.white,
        ),
        const Text(
          'Remember Me',
          style: Styles.textStyle13,
        ),
        const Spacer(),
        const Text(
          'Forgot Password?',
          style: Styles.textStyle13,
        ),
      ],
    );
  }
}
