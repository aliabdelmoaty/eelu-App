import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/core/utils/cache_helper.dart';
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
  final String _uid = CacheHelper.getData(key: 'uid');
  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> getCourses() async {
    try {
      emit(GetCoursesLoading());
      await db.collection('courses').get().then((value) {
        for (var element in value.docs) {
          coursesName!.add(element.id);
        }
        emit(GetCoursesSuccess());
      }).catchError((e) {
        emit(GetCoursesError(e: e.toString()));
      });
    } catch (e) {
      emit(GetCoursesError(e: e.toString()));
    }
  }

  Future<void> getDataCourses() async {
    try {
      emit(GetDataCoursesLoading());

      db.collection('courses').get().then((value) {
        itemCourseModel?.clear();
        for (var element in value.docs) {
          final Map<String, dynamic>? data = element.data();
          itemCourseModel?.add(ItemCourseModel.fromJson({
            'image': data?['image'],
            'lectures': Map<String, String>.from(data?['lectures'] ?? {}),
            'videos': Map<String, String>.from(data?['videos'] ?? {}),
            'doctors': List<String>.from(data?['doctors'] ?? []),
          }));
        }
        emit(GetDataCoursesSuccess());
      });
    } catch (e) {
      emit(GetDataCoursesError(e: e.toString()));
    }
  }

  Future<void> getDataUser() async {
    try {
      emit(GetUserDataLoading());
      await db.collection('users').doc(_uid).get().then((value) {
        userModel = RegisterModel.fromJson(value.data()!);
      });
      emit(GetUserDataSuccess());
    } catch (e) {
      emit(GetUserDataError(e: e.toString()));
    }
  }

  Future<void> getAllData() async {
    emit(GetAllDataLoading());
    try {
      await getDataCourses().then((value) async {
        await getDataUser().then((value) async {
          await getCourses().then((value) {
            emit(GetAllDataSuccess());
          });
        });
      });
    } catch (e) {
      emit(GetAllDataError());
    }
  }
}
