import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/assets.dart';
import 'package:payment/core/utils/colors.dart';
import 'package:payment/core/utils/fallback_loading.dart';
import 'package:payment/core/utils/validator.dart';
import 'package:payment/core/widgets/custom_button.dart';
import 'package:payment/core/widgets/custom_text_field.dart';
import 'package:payment/features/forgot%20Password/presentation/data/cubit/forgot_password_cubit.dart';

class ForgetPasswordBody extends StatelessWidget {
  const ForgetPasswordBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state is ForgotPasswordSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                  backgroundColor: ColorsApp.blue,
                ));
              }
              if (state is ForgotPasswordError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ));
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(
                    height: 200.h,
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                      controller: email,
                      assetName: Assets.imagesEmail,
                      validator: (value) => Validator().validateEmail(value!),
                      label: 'Email'),
                  SizedBox(
                    height: 20.h,
                  ),
                  ConditionalBuilder(
                    condition: state is! ForgotPasswordLoading,
                    builder: (context) => CustomButton(
                        text: 'Send',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ForgotPasswordCubit.get(context)
                                .sendEmail(email.text)
                                .then((value) {
                              GoRouter.of(context).go('/login');
                            });
                          }
                        }),
                    fallback: (context) => const FallbackLoading(),
                  )
                ],
              );
            },
          ),
        ));
  }
}
