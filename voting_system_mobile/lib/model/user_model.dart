class User {
  String firstName;
  String lastName;
  String phoneNumber;
  String userName;
  String email;
  String userId;

  User(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.userName,
      this.email,
      this.userId});

  factory User.fromJson(Map<String, dynamic> json) => User(
      firstName: json["firstname"] != null ? json["firstName"] : "",
      lastName: json["lastname"] != null ? json["lastname"] : "",
      phoneNumber: json["phone"] != null ? json["phone"] : "",
      userName: json["username"] != null ? json["username"] : "",
      userId: json["id"] != null ? json["id"] : "");
}
