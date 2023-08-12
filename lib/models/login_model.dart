class LoginModel {

  bool? status;
  String? message;
  LoginDataModel? data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? LoginDataModel.fromJson(json['data']) : null;
  }

}

class LoginDataModel {

  User? user;
  String? token;

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

}

class User {

  int? user_id;
  String? name;
  String? email;
  //String? img;
  String? role;
  String? gender;
  String? phone_number;

  User.fromJson(Map<String, dynamic> json) {
    user_id = json['id'];
    name = json['name'];
    email = json['email'];
    //img = json['img'];
    role = json['role'];
    gender = json['gender'];
    phone_number = json['phone_number'];
  }

}