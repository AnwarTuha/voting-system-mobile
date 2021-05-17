
class VerificationResponseModel{
  String role;
  String orgId;
  String userId;
  bool isVerified;
  String roleId;

  VerificationResponseModel({this.userId, this.orgId, this.role, this.isVerified, this.roleId});

  factory VerificationResponseModel.fromJson(Map<String, dynamic> json) => VerificationResponseModel(
    role: json["role"] != null ? json["role"] : "",
    orgId: json["orgId"] != null ? json["orgId"] : "",
    userId: json["userId"] != null ? json["userId"] : "",
    roleId: json["id"] != null ? json["id"] : "",
    isVerified: json["isVerified"]
  );

}


class VerificationRequestModel{
  String roleName;
  String orgId;
  String userId;

  VerificationRequestModel({this.orgId, this.roleName, this.userId});

  Map<String, dynamic> toJson() => {
    "role" : roleName,
    "orgId": orgId,
    "userId": userId
  };

}