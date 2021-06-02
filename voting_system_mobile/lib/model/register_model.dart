import 'package:voting_system_mobile/model/user_model.dart';

class RegisterResponseModel {
  final User user;
  final ResponseError error;

  RegisterResponseModel({this.user, this.error});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        error: json["error"] != null
            ? ResponseError.fromJson(json["error"])
            : null);
  }
}

class RegisterRequestModel {
  String firstName;
  String lastName;
  String userName;
  String phoneNumber;
  String email;
  String password;

  RegisterRequestModel(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.userName,
      this.email,
      this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "firstname": firstName.trim(),
      "lastname": lastName.trim(),
      "phone": phoneNumber.trim(),
      "username": userName.trim(),
      "email": email.trim(),
      "password": password.trim()
    };

    return map;
  }
}

class ResponseError {
  int statusCode;
  String errorName;
  String errorMessage;
  ErrorDetails errorDetails;

  ResponseError(
      {this.statusCode, this.errorName, this.errorMessage, this.errorDetails});

  factory ResponseError.fromJson(Map<String, dynamic> json) => ResponseError(
        statusCode: json["statusCode"] != null ? json["statusCode"] : "",
        errorName: json["name"] != null ? json["name"] : "",
        errorMessage: json["message"] != null ? json["message"] : "",
        errorDetails: ErrorDetails.fromJson(json["details"]),
      );
}

class ErrorDetails {
  String context;
  ErrorCodes codes;
  ErrorCodes messages;

  ErrorDetails({this.codes, this.context, this.messages});

  factory ErrorDetails.fromJson(Map<String, dynamic> json) => ErrorDetails(
      context: json["context"] != null ? json["context"] : "",
      codes: ErrorCodes.fromJson(json["codes"]),
      messages: ErrorCodes.fromJson(json["messages"]));
}

class ErrorCodes {
  List<String> email;
  List<String> userName;

  ErrorCodes({this.email, this.userName});

  factory ErrorCodes.fromJson(Map<String, dynamic> json) => ErrorCodes(
      email: json["email"] != null
          ? List<String>.from(
              json["email"].map((emailErrorCode) => emailErrorCode))
          : "",
      userName: json["username"] != null
          ? List<String>.from(
              json["username"].map((userNameErrorCode) => userNameErrorCode))
          : "");
}
