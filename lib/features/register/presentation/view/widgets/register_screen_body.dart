import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/utils/app_router.dart';
import 'package:payment/core/utils/assets.dart';
import 'package:payment/core/utils/fallback_loading.dart';
import 'package:payment/core/utils/styles.dart';
import 'package:payment/core/utils/validator.dart';
import 'package:payment/core/widgets/custom_button.dart';
import 'package:payment/core/widgets/custom_text_field.dart';
import 'package:payment/features/register/presentation/data/cubit/register_cubit.dart';
import 'package:payment/features/register/presentation/view/widgets/text_span_register.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController? name = TextEditingController();
    TextEditingController? email = TextEditingController();
    TextEditingController? id = TextEditingController();
    TextEditingController? password = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                GoRouter.of(context).push(AppRouter.home);
              }
            },
            builder: (context, state) {
              return Form(
                key: formKey,
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
                    CustomTextField(
                      validator: (value) => Validator().validateName(value!),
                      controller: name,
                      label: 'Name',
                      assetName: Assets.imagesName,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      validator: (value) => Validator().validateEmail(value!),
                      controller: email,
                      label: 'Email',
                      hint: '0000000@student.eelu.edu.eg',
                      assetName: Assets.imagesEmail,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      validator: (value) => Validator().validateID(value!),
                      controller: id,
                      label: 'Id',
                      hint: 'Enter your id like 0000000',
                      assetName: Assets.imagesId,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      validator: (value) =>
                          Validator().validatePassword(value!),
                      controller: password,
                      label: 'Password',
                      assetName: Assets.imagesPassword,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    ConditionalBuilder(
                        condition: state is! RegisterLoading,
                        builder: (context) => CustomButton(
                            text: 'Sign Up',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).register(
                                  email: email.text,
                                  password: password.text,
                                  name: name.text,
                                  id: int.parse(id.text),
                                );
                              }
                            }),
                        fallback: (context) => const FallbackLoading()),
                    SizedBox(
                      height: 10.h,
                    ),
                    const TextSpanRegister(),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

