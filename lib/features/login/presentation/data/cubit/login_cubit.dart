// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  void login({required String id, required String password}) {
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: id, password: password)
        .then((value) => {
              print(value.user),
              emit(LoginSuccess(value.user!.uid)),
            })
        .catchError((e) {
      print('error in login cubit: $e');
      emit(LoginError(e.toString()));
      // }
      return e;
    });
  }

  IconData suffix = Icons.visibility_rounded;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded;
    emit(ChangePasswordVisibility());
  }
}
