import 'dart:convert';

RoleDetailResponseModel roleDetailFromJson(String str) => RoleDetailResponseModel.fromJson(jsonDecode(str));

class RoleDetailResponseModel{

  RoleDetail roleDetail;

  RoleDetailResponseModel({this.roleDetail});

  factory RoleDetailResponseModel.fromJson(Map<String, dynamic> json) => RoleDetailResponseModel(
    roleDetail: RoleDetail.fromJson(json["data"]),
  );
}

class RoleDetail {

  String roleName;
  String orgName;
  String parentRoleId;

  RoleDetail({this.roleName, this.orgName, this.parentRoleId});

  factory RoleDetail.fromJson(Map<String, dynamic> json) => RoleDetail(
    roleName: json["roleName"],
    orgName: json["orgName"],
    parentRoleId: json["parentRole"]
  );

  Map<String, dynamic> toJson() => {
    "roleName": roleName,
    "orgName": orgName,
    "parentRoleId": parentRoleId
  };

}

class RoleDetailRequestModel{
  String roleId;

  RoleDetailRequestModel({this.roleId});

  Map<String, dynamic> toJson() => {
    "roleId": roleId
  };

}

