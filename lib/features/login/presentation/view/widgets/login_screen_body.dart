import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/assets.dart';
import 'package:payment/core/utils/fallback_loading.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/core/utils/validator.dart';
import 'package:payment/core/widgets/custom_button.dart';
import 'package:payment/core/widgets/custom_text_field.dart';
import 'package:payment/features/login/presentation/data/cubit/login_cubit.dart';
import 'package:payment/features/login/presentation/view/widgets/row_remember_and_forgot.dart';
import 'package:payment/features/login/presentation/view/widgets/text_span_login.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController? email = TextEditingController();
    TextEditingController? password = TextEditingController();
    var loginCubit = LoginCubit.get(context);
    return SingleChildScrollView(
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            GoRouter.of(context).go('/home');
          }
          if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Form(
              key: formKey,
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
                  CustomTextField(
                      controller: email,
                      label: 'email',
                      validator: (value) => Validator().validateEmail(value!),
                      assetName: Assets.imagesEmail),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                      onPressed: () {
                        loginCubit.changePasswordVisibility();
                      },
                      icon: loginCubit.suffix,
                      controller: password,
                      label: 'password',
                      isPassword: loginCubit.isPassword,
                      validator: (value) =>
                          Validator().validatePasswordLogin(value!),
                      assetName: Assets.imagesPassword),
                  SizedBox(
                    height: 20.h,
                  ),
                  const RowRememberAndForgot(),
                  SizedBox(
                    height: 39.h,
                  ),
                  ConditionalBuilder(
                    condition: state is! LoginLoading,
                    builder: (context) => CustomButton(
                        text: 'Sign In',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            loginCubit.login(
                                id: email.text, password: password.text);
                          }
                        }),
                    fallback: (context) => const FallbackLoading(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const TextSpanLogin(),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
