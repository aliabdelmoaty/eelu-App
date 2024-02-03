import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/app_router.dart';
import 'package:payment/core/utils/assets.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/core/widgets/custom_button.dart';
import 'package:payment/core/widgets/custom_text_field.dart';
import 'package:payment/features/home/presentation/view/home_screen.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80.h,
            ),
            Center(child: SvgPicture.asset(Assets.imagesLOGO)),
            SizedBox(
              height: 60.h,
            ),
            const Text(
              'Let’s Sign In.!',
              style: Styles.textStyle24,
            ),
            SizedBox(
              height: 10.h,
            ),
            const Text('Login to Your Account to Continue your Courses',
                style: Styles.textStyle70014),
            SizedBox(
              height: 50.h,
            ),
            const CustomTextField(label: 'Id', assetName: Assets.imagesId),
            SizedBox(
              height: 20.h,
            ),
            const CustomTextField(
                label: 'Password', assetName: Assets.imagesPassword),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (v) {},
                  activeColor: const Color(0xff167F71),
                  overlayColor:
                      MaterialStateProperty.all(const Color(0xff167F71)),
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
            ),
            SizedBox(
              height: 39.h,
            ),
            CustomButton(
                text: 'Sign In',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                }),
            SizedBox(
              height: 50.h,
            ),
            Text.rich(TextSpan(children: [
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
            ])),
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
