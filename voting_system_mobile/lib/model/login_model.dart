class LoginResponseModel {
  final String user;
  final String error;

  LoginResponseModel({this.user, this.error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return LoginResponseModel(
        user: json["user"] != null ? json["user"] : "",
        error: json["error"] != null ? json["error"] : "");
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
