// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login({required String id, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: id, password: password)
          .then((value) {
        emit(LoginSuccess());
      }).catchError((e) {
        print(e);
        emit(LoginError('oops! There was an error, try again'));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      emit(LoginError('No user found for that email.'));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
      emit(LoginError('Wrong password provided for that user.'));
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      emit(LoginError('oops! There was an error, try again'));
      print(e);
    }
  }
}
