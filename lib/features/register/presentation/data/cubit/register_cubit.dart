import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:payment/features/register/model/register_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  static var db = FirebaseFirestore.instance;

  void register({
    required String email,
    required String password,
    required String name,
    required int id,
    required String image,
  }) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        createUser(
            email: email,
            uid: value.user!.uid,
            name: name,
            id: id,
            image: image);
        emit(RegisterSuccess(value.user!.uid));
      }).catchError((e) {
        emit(RegisterError('please try again later'));
      });
    } on FirebaseAuthException catch (e) {
      if (e.message == 'weak-password') {
        emit(RegisterError('The password provided is too weak.'));
      } else if (e.message == 'email-already-in-use') {
        emit(RegisterError('The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterError('please try again later'));
    }
  }

  void createUser({
    required String email,
    required String name,
    required int id,
    required String image,
    required String uid,
  }) async {
    emit(CreateUserLoading());
    RegisterModel registerModel =
        RegisterModel(name: name, email: email, id: id, uid: uid, image: image);
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(registerModel.toJson());
      emit(CreateUserSuccess());
    } catch (e) {
      emit(CreateUserError());
    }
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
