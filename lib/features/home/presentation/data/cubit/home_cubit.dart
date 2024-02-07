import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/core/constant.dart';
import 'package:payment/features/home/presentation/data/model/course_model.dart';
import 'package:payment/features/home/presentation/data/model/item_course_model.dart';
import 'package:payment/features/register/model/register_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  CourseModel? courseModel;
  List<String>? coursesName = [];
  var db = FirebaseFirestore.instance;
  List<ItemCourseModel>? itemCourseModel = [];
  RegisterModel? userModel;
  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> getCourses() async {
    try {
      emit(GetCoursesLoading());
      await db.collection('courses').get().then((value) {
        for (var element in value.docs) {
          coursesName!.add(element.id);
        }

        emit(GetCoursesSuccess());
      }).catchError((e) {});
    } catch (e) {
      emit(GetCoursesError(e: e.toString()));
    }
  }

  Future<void> getDataCourses() async {
    try {
      emit(GetDataCoursesLoading());
      await db.collection('courses').get().then((value) {
        for (var element in value.docs) {
          final Map<String, dynamic> data = element.data();
          itemCourseModel?.add(ItemCourseModel.fromJson({
            'image': data['image'],
            'lectures': Map<String, String>.from(data['lectures'] ?? {}),
            'videos': Map<String, String>.from(data['videos'] ?? {}),
            'doctors': List<String>.from(data['doctors'] ?? []),
          }));
        }
        emit(GetDataCoursesSuccess());
      }).catchError((e) {
        print(e.toString());
        emit(GetDataCoursesError(e: e.toString()));
      });
    } catch (e) {
      print(e.toString());
      emit(GetDataCoursesError(e: e.toString()));
    }
  }

  Future<void> getDataUser() async {
    try {
      print(token);
      emit(GetUserDataLoading());
      await db.collection('users').doc(token).get().then((value) {
        print(value.exists);
        print(value.data());
        userModel = RegisterModel.fromJson(value.data()!);
      });
      print(userModel?.email.toString());
      emit(GetUserDataSuccess());
    } catch (e) {
      print('error user:${e.toString()}');
      emit(GetUserDataError(e: e.toString()));
    }
  }
}
