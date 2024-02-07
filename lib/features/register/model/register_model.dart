class RegisterModel{
  String name;
  String email;
  String uid;
  String image;
  int id;
  RegisterModel({required this.name, required this.email, required this.id,required this.image,
      required this.uid});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'id': id,
      'uid': uid,
      'image': image,
    };
  }
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      name: json['name'],
      email: json['email'],
      image: json['image'],
      id: json['id'],
      uid: json['uid']
    );
  }
}