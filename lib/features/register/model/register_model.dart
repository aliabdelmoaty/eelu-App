class RegisterModel{
  String name;
  String email;
  String uid;
  int id;

  RegisterModel({required this.name, required this.email, required this.id,
      required this.uid});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'id': id,
      'uid': uid
    };
  }
}