import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:voting_system_mobile/model/organization_model.dart';
import 'package:voting_system_mobile/model/register_model.dart';
import 'package:voting_system_mobile/model/login_model.dart';
import 'package:voting_system_mobile/utils/constants_util.dart';
import 'package:voting_system_mobile/model/roles_model.dart';

import '../model/login_model.dart';

class RequestService {
  // Login service
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    String url = "$kBaseUrl/Voters/login";
    var response;
    try {
      response =
      await http.post(Uri.parse(url), body: loginRequestModel.toJson());
      if (response != null){
        return LoginResponseModel.fromJson(
            new Map<String, dynamic>.from(json.decode(response.body.toString())));
      }
    } catch (e) {
      if (response != null){
        return LoginResponseModel.fromJson(
            new Map<String, dynamic>.from(jsonDecode(response.body)));
      }
    }
  }

  // Register service
  Future<RegisterResponseModel> register(
      RegisterRequestModel registerRequestModel) async {
    String url = "$kBaseUrl/Voters/register";
    var response;

    try {
      response =
          await http.post(Uri.parse(url), body: registerRequestModel.toJson());
      return RegisterResponseModel.fromJson(
          new Map<String, dynamic>.from(jsonDecode(response.body)));
    } catch (e) {
      print(response.body);
      return RegisterResponseModel.fromJson(
          new Map<String, dynamic>.from(jsonDecode(response.body)));
    }
  }

  // Fetch Organization Service

  Future<List<Organization>> fetchOrganizations() async {
    String url = "$kBaseUrl/Organizations";
    var response;

    response = await http.get(Uri.parse(url));
    print("Success" + response.body);
    return organizationFromJson(response.body);
  }

  // Fetch Roles Service

  Future<RoleResponseModel> fetchRoles(RoleRequestModel roleRequestModel) async{
    String url = "$kBaseUrl/roles/getRolesInOrg";

    print("Organization Id: ${roleRequestModel.orgId}");

    var response;

    try{
      response = await http.post(Uri.parse(url), body: roleRequestModel.toJson());
      print(response.body);
      return RoleResponseModel.fromJson(
          new Map<String, dynamic>.from(jsonDecode(response.body))
      );
    } catch (e) {
      print(response.body);
      return RoleResponseModel.fromJson(
        new Map<String, dynamic>.from(jsonDecode(response.body))
      );
    }
  }

}
