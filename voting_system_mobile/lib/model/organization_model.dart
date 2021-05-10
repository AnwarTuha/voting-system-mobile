import 'package:flutter/cupertino.dart';

class OrganizationResponseModel{
  final String orgId;
  final String adminId;

  OrganizationResponseModel({this.orgId, this.adminId});

  factory OrganizationResponseModel.fromJson(Map<String, dynamic> json) {
    return OrganizationResponseModel(
        orgId: json["id"] != null ? json["id"] : "",
        adminId: json["adminId"] != null ? json["adminId"]: ""
    );
  }
}