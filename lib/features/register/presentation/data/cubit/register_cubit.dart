import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:payment/core/utils/cache_helper.dart';
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
  }) async {
    emit(RegisterLoading());
    try {
       await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        createUser(email: email, uid: value.user!.uid, name: name, id: id);
        CacheHelper.saveData(key: 'uid', value: value.user!.uid);
        emit(RegisterSuccess());
      }).catchError((e) {
        print(e);
        emit(RegisterError());
      });
    } on FirebaseAuthException catch (e) {
      emit(RegisterError());

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      emit(RegisterError());

      print(e);
    }
  }

  void createUser({
    required String email,
    required String name,
    required int id,
    required String uid,
  }) async {
    emit(CreateUserLoading());
    RegisterModel registerModel =
        RegisterModel(name: name, email: email, id: id, uid: uid);
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(registerModel.toJson());
      emit(CreateUserSuccess());
    } catch (e) {
      print(e);
      emit(CreateUserError());
    }
  }
}
