import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  LoginCubit get(context) => BlocProvider.of(context);

  void login({required String id, required String password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: id, password: password);
  }
}
