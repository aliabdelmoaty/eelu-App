import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/features/home/presentation/data/model/course_model.dart';
import 'package:payment/features/home/presentation/data/model/item_course_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  CourseModel? courseModel;
  List<String>? coursesName = [];
  var db = FirebaseFirestore.instance;
  List<ItemCourseModel>? itemCourseModel = [];

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
          itemCourseModel?.add(ItemCourseModel?.fromJson(element.data()));
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
}
