class LoginModel{
  String id;
  String password;

  LoginModel({required this.id, required this.password});

  Map<String, dynamic> toJson() => {
    'email': id,
    'password': password,
  };
  
}