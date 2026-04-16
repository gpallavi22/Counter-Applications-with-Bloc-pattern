class LoginModel {
  bool? success;
  String? message;
  UserData? data;

  LoginModel({
    this.success,
    this.message,
    this.data,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  String? token;
  String? name;
  String? email;

  UserData({
    this.token,
    this.name,
    this.email,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    email = json['email'];
  }
}
