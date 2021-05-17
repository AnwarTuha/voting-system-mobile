import 'dart:convert';

Role roleFromJson(String str) => Role.fromJson(json.decode(str));

String roleToJson(Role data) => json.encode(data.toJson());

class RoleResponseModel{
  List<Role> roles;
  ResponseError error;

  RoleResponseModel({this.roles, this.error});

  factory RoleResponseModel.fromJson(Map<String, dynamic> json) => RoleResponseModel(
    roles: json["roles"] != null ? List<Role>.from(json["roles"].map((x) => Role.fromJson(x))) : [],
    error:  json["error"] != null ? ResponseError.fromJson(json["error"]) : null
  );

}


class Role{
  String parentRoleId;
  String orgId;
  String roleName;
  String roleId;

  Role({this.orgId, this.roleName, this.parentRoleId, this.roleId});

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    parentRoleId: json['parentRoleId'] != null ? json['parentRoleId'] : '',
    orgId: json['orgId'] != null ? json['orgId'] : '',
    roleName: json['roleName'] != null ? json['roleName'] : '',
    roleId: json['id'] != null ? json['id'] : ''
  );

  Map<String, dynamic> toJson() => {
    "parentRoleId": parentRoleId,
    "orgId": orgId,
    "roleName": roleName,
    "roleId": roleId
  };
}

class RoleRequestModel{
  String orgId;

  RoleRequestModel({this.orgId});

  Map<String, dynamic> toJson() => {
    "orgId": orgId
  };
}

class ResponseError{
  ResponseError({
    this.name,
    this.message,
    this.code,
  });

  String name;
  String message;
  String code;

  factory ResponseError.fromJson(Map<String, dynamic> json) => ResponseError(
    name: json["name"],
    message: json["message"],
    code: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": code,
    "name": name,
    "message": message,
  };
}