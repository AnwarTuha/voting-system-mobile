class RegisterResponseModel {
  final String user;
  final String error;

  RegisterResponseModel({this.user, this.error});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return RegisterResponseModel(
        user: json["user"] != null ? json["user"] : "",
        error: json["error"] != null ? json["error"] : "");
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
