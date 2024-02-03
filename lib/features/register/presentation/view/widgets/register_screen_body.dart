import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payment/core/utils/assets.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/core/widgets/custom_button.dart';
import 'package:payment/core/widgets/custom_text_field.dart';
import 'package:payment/features/login/presentation/view/login_screen.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Center(child: SvgPicture.asset(Assets.imagesLOGO)),
              SizedBox(
                height: 50.h,
              ),
              const Text(
                'Getting Started.!',
                style: Styles.textStyle24,
              ),
              SizedBox(
                height: 10.h,
              ),
              const Text(
                'Create an Account to Continue your all Courses',
                style: Styles.textStyle70014,
              ),
              SizedBox(
                height: 45.h,
              ),
              const CustomTextField(
                label: 'Name',
                assetName: Assets.imagesName,
              ),
              SizedBox(
                height: 20.h,
              ),
              const CustomTextField(
                label: 'Email',
                hint: '0000000@student.eelu.edu.eg',
                assetName: Assets.imagesEmail,
              ),
              SizedBox(
                height: 20.h,
              ),
              const CustomTextField(
                label: 'Id',
                hint: 'Enter your id like 0000000',
                assetName: Assets.imagesId,
              ),
              SizedBox(
                height: 20.h,
              ),
              const CustomTextField(
                label: 'Password',
                assetName: Assets.imagesPassword,
              ),
              SizedBox(
                height: 50.h,
              ),
              const CustomButton(
                text: 'Sign Up',
              ),
              SizedBox(
                height: 10.h,
              ),
              Text.rich(TextSpan(children: [
                const TextSpan(
                  text: 'Already have an Account? ',
                  style: Styles.textStyle70014,
                ),
                TextSpan(
                    text: 'SIGN IN',
                    style: Styles.textStyle80014,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      })
              ])),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
