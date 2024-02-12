class ItemCourseModel {
  final String image;
  final Map<String, String> lectures;
  final Map<String, String> videos;
  final List<String> doctors;

  ItemCourseModel({
    required this.image,
    required this.lectures,
    required this.videos,
    required this.doctors,
  });

  factory ItemCourseModel.fromJson(Map<String, dynamic> json) {
    return ItemCourseModel(
      image: json['image'],
      lectures: _parseMap(json['lectures']),
      videos: _parseMap(json['videos']),
      doctors: List<String>.from(json['doctors']),
    );
  }

  static Map<String, String> _parseMap(Map<String, dynamic> map) {
    Map<String, String> result = {};
    map.forEach((key, value) {
      result[key] = value.toString();
    });
    return result;
  }

  void add(ItemCourseModel itemCourseModel) {}
}
