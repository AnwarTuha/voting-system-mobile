class User {
  String token;
  String firstName;
  String lastName;
  String phoneNumber;
  String userName;
  String email;
  String userId;
  String orgId;
  String role;
  bool isComplete;

  User(
      {
      this.token,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.userName,
      this.email,
      this.userId,
      this.orgId,
      this.role,
      this.isComplete});

  factory User.fromJson(Map<String, dynamic> json) => User(
      token: json["token"] != null ? json["token"] : "",
      firstName: json["firstname"] != null ? json["firstName"] : "",
      lastName: json["lastname"] != null ? json["lastname"] : "",
      phoneNumber: json["phone"] != null ? json["phone"] : "",
      userName: json["username"] != null ? json["username"] : "",
      userId: json["userid"] != null ? json["userid"] : "",
      orgId: json["orgId"] != null ? json["orgId"] : "",
      role: json["role"] != null ? json["role"] : "",
      isComplete: json["isComplete"]
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstName,
    "lastname": lastName,
    "phone": phoneNumber,
    "username": userName,
    "id": userId,
    "orgId": orgId,
    "role": role
  };

}
