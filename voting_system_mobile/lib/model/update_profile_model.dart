import 'dart:convert';

import 'package:voting_system_mobile/model/response_error_model.dart';

import 'user_model.dart';

UpdateProfileResponseModel updateProfileResponseModelFromJson(String str) =>
    UpdateProfileResponseModel.fromJson(json.decode(str));

String updateProfileResponseModelToJson(UpdateProfileResponseModel data) =>
    json.encode(data.toJson());

class UpdateProfileResponseModel {
  UpdateProfileResponseModel({
    this.response,
  });

  Response response;

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponseModel(
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
      };
}

class Response {
  Response({this.message, this.user, this.error});

  String message;
  User user;
  HttpError error;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        message: json["message"] != null ? json["message"] : null,
        user: json["voter"] != null ? User.fromJson(json["voter"]) : null,
        error: json["error"] != null ? HttpError.fromJson(json["error"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "voter": User().toJson(),
      };
}

class UpdateProfileRequestModel {
  String firstName;
  String lastName;
  String phone;
  String id;
  String authenticationToken;

  UpdateProfileRequestModel(
      {this.firstName,
      this.lastName,
      this.phone,
      this.id,
      this.authenticationToken});

  Map<String, dynamic> toJson() =>
      {"firstname": firstName, "lastname": lastName, "phone": phone};
}
