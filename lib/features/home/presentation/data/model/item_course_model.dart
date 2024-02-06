class ItemCourseModel {
  final String image;
  final List<String> lectures;
  final List<String> videos;
  final List<String> doctors;

  

  ItemCourseModel( {required this.image, required this.lectures, required this.videos,required this.doctors,});
  factory ItemCourseModel.fromJson(Map<String, dynamic> json) {
    return ItemCourseModel(
      image: json['image'],
      lectures: List<String>.from(json['lectures']),
      videos: List<String>.from(json['videos']),
      doctors: List<String>.from(json['doctors']),
    );
  }
}
