import 'package:flutter/material.dart';
import 'package:payment/features/register/presentation/view/widgets/register_screen_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RegisterScreenBody(),
    );
  }
}
