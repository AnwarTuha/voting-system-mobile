import 'package:flutter/material.dart';

class VerifyResponseModel{

}

class VerifyRequestModel{
  final String organizationId;
  final String roleId;
  final String userId;

  VerifyRequestModel(this.organizationId, this.roleId, this.userId);

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {
      "role": roleId,
      "orgId": organizationId,
      "userId": userId
    };

    return map;

  }

}