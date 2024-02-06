import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());
  static ForgotPasswordCubit get(context) => BlocProvider.of(context);
  Future<void> sendEmail(String email) async {
    try {
      emit(ForgotPasswordLoading());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ForgotPasswordSuccess('Check your email to change your password'));
    } on FirebaseAuthException catch (e) {
      emit(ForgotPasswordError(e.message!));
    }
  }
}
