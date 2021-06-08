import 'dart:convert';

import 'package:voting_system_mobile/model/response_error_model.dart';

RoleDetailResponseModel roleDetailResponseModelFromJson(String str) =>
    RoleDetailResponseModel.fromJson(json.decode(str));

String roleDetailResponseModelToJson(RoleDetailResponseModel data) =>
    json.encode(data.toJson());

class RoleDetailResponseModel {
  RoleDetailResponseModel({this.data, this.error});

  RoleDetail data;
  HttpError error;

  factory RoleDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      RoleDetailResponseModel(
        data: json["data"] != null ? RoleDetail.fromJson(json["data"]) : null,
        error: json["error"] != null ? HttpError.fromJson(json["error"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class RoleDetail {
  RoleDetail({
    this.roleName,
    this.orgName,
    this.parentRole,
  });

  String roleName;
  String orgName;
  String parentRole;

  factory RoleDetail.fromJson(Map<String, dynamic> json) => RoleDetail(
        roleName: json["roleName"],
        orgName: json["orgName"],
        parentRole: json["parentRole"],
      );

  Map<String, dynamic> toJson() => {
        "roleName": roleName,
        "orgName": orgName,
        "parentRole": parentRole,
      };
}

class RoleDetailRequestModel {
  String roleId;
  String authenticationToken;

  RoleDetailRequestModel({this.roleId, this.authenticationToken});

  Map<String, dynamic> toJson() => {"roleId": roleId};
}
