import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:voting_system_mobile/model/organization_model.dart';
import 'package:voting_system_mobile/model/register_model.dart';
import 'package:voting_system_mobile/model/login_model.dart';
import 'package:voting_system_mobile/utils/constants_util.dart';

import '../model/login_model.dart';

class RequestService {

  // Login service
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    String url = "$kBaseUrl/Voters/login";
    var response;
    try {
      response = await http.post(Uri.parse(url), body: loginRequestModel.toJson());
      return LoginResponseModel.fromJson(
        new Map<String, dynamic>.from(json.decode(response.body.toString()))
      );
    } catch (e) {
      return LoginResponseModel.fromJson(
        new Map<String, dynamic>.from(jsonDecode(response.body)["error"]));
    }
  }

  // Register service
  Future<RegisterResponseModel> register(RegisterRequestModel registerRequestModel) async {
    String url = "$kBaseUrl/Voters/register";
    var response;

    try{
      response = await http.post(Uri.parse(url), body: registerRequestModel.toJson());
      return RegisterResponseModel.fromJson(
        new Map<String, dynamic>.from(jsonDecode(response.body)["user"])
      );
    } catch (e){
      print(response.body);
      return RegisterResponseModel.fromJson(
        new Map<String, dynamic>.from(jsonDecode(response.body)["error"]["details"]["messages"])
      );
    }

  }

  // Fetch Organization Service

  Future<OrganizationResponseModel> fetchOrganizations() async {
    String url = "$kBaseUrl/Organizations";
    var response;

    try{
      response = await http.get(Uri.parse(url));
      print(response.body);
      return OrganizationResponseModel.fromJson(
        new Map<String, dynamic>.from(jsonDecode(response.body))
      );
    } catch (e){
      print(response.body);
      return OrganizationResponseModel.fromJson(
        new Map<String, dynamic>.from(jsonDecode(response.body),
        ),
      );
    }
  }
}
