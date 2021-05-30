import 'dart:convert';
import 'package:voting_system_mobile/model/user_model.dart';

import 'response_error_model.dart';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {


  final User user;

  final HttpError error;

  LoginResponseModel({
      this.user,
      this.error,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      user: json["user"] != null ? User.fromJson(json["user"]) : null,
      error: json["error"] != null ? HttpError.fromJson(json["error"]) : null,
    );
  }
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({this.email, this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email.trim(),
      "password": password.trim()
    };

    return map;
  }
}
