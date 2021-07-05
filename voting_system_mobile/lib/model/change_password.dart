import 'package:voting_system_mobile/model/response_error_model.dart';

class ChangePasswordRequestModel {
  String oldPassword;
  String newPassword;

  ChangePasswordRequestModel({this.newPassword, this.oldPassword});

  Map<String, dynamic> toJson() => {
        "oldPassword": oldPassword.trim(),
        "newPassword": newPassword.trim(),
      };
}

class ChangePasswordResponseModel {
  String response;
  HttpError error;

  ChangePasswordResponseModel({this.response, this.error});

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) => ChangePasswordResponseModel(
        response: json["response"] != null ? json["response"] : null,
        error: json["error"] != null ? json["error"] : null,
      );
}
