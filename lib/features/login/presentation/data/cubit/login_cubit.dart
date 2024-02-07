// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/core/utils/cache_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login({required String id, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: id, password: password)
          .then((value) => {
                CacheHelper.saveData(key: 'uid', value: value.user!.uid),
                emit(SaveUidSuccess())
              })
          // ignore: body_might_complete_normally_catch_error
          .catchError((e) {
        print('error in login cubit: $e');
        emit(SaveUidError());
      });
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.message == 'user-not-found') {
        emit(LoginError('No user found for that email.'));
        print('No user found for that email.');
      } else if (e.message == 'wrong-password') {
        emit(LoginError('Wrong password provided for that user.'));
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      emit(LoginError('oops! There was an error, try again'));
      print('error in login cubit: $e');
    }
  }

  IconData suffix = Icons.visibility_rounded;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded;
    emit(ChangePasswordVisibility());
  }
}
