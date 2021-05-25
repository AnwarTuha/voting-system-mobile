import 'dart:convert';
import 'response_error_model.dart';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {


  final String token;
  final String userId;
  final String orgId;
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String role;

  final ResponseError error;
  final bool isComplete;

  LoginResponseModel(
      {
      this.userId,
      this.orgId,
      this.userName,
      this.email,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.role,
      this.isComplete,
      this.token,
      this.error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] != null ? json["token"] : "",
      userId: json["userid"] != null ? json["userid"] : "",
      orgId: json["orgid"] != null ? json["orgid"] : "",
      userName: json["username"] != null ? json["username"] : "",
      email: json["email"] != null ? json["email"] : "",
      firstName: json["firstname"] != null ? json["firstname"] : "",
      lastName: json["lastname"] != null ? json["lastname"] : "",
      phoneNumber: json["phone"] != null ? json["phone"] : "",
      role: json["role"] != null ? json["role"] : "",
      isComplete: json["isComplete"] != null ? json["isComplete"] : false,
      error:
          json["error"] != null ? ResponseError.fromJson(json["error"]) : null,
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
