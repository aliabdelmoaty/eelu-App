import 'package:payment/features/home/presentation/data/model/item_course_model.dart';

class CourseModel{
  // final String name;
  final ItemCourseModel itemCourseModel;
  CourseModel({
    // required this.name,
    required this.itemCourseModel,

  });

  factory CourseModel.fromJson(Map<String, dynamic> json){
    return CourseModel(
      // name: json['name'],
      
       itemCourseModel: ItemCourseModel.fromJson(json['itemCourseModel']),
    );
  }
}