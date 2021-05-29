import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voting_system_mobile/model/organization_model.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/model/register_model.dart';
import 'package:voting_system_mobile/model/login_model.dart';
import 'package:voting_system_mobile/model/role_detail.dart';
import 'package:voting_system_mobile/model/verification_request_model.dart';
import 'package:voting_system_mobile/model/roles_model.dart';
import 'package:voting_system_mobile/utils/app_url.dart';

import '../model/login_model.dart';

class RequestService {
  // Login service
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    String url = "${AppUrl.kBaseUrl}/Voters/login";
    var response;
    try {
      response = await http.post(
        Uri.parse(url),
        body: loginRequestModel.toJson(),
      );
      if (response != null) {
        print("success: $response");
        return LoginResponseModel.fromJson(
          new Map<String, dynamic>.from(
            json.decode(
              response.body.toString(),
            ),
          ),
        );
      } else {
        throw Exception();
      }
    } catch (e) {
      if (response != null) {
        return LoginResponseModel.fromJson(
          new Map<String, dynamic>.from(
            jsonDecode(response.body),
          ),
        );
      } else {
        print("Error: $response");
      }
    }
    return null;
  }

  // Register service
  Future<RegisterResponseModel> register(
      RegisterRequestModel registerRequestModel) async {
    String url = "${AppUrl.kBaseUrl}/Voters/register";
    var response;

    try {
      response = await http.post(
        Uri.parse(url),
        body: registerRequestModel.toJson(),
      );
      return RegisterResponseModel.fromJson(
        new Map<String, dynamic>.from(
          jsonDecode(response.body),
        ),
      );
    } catch (e) {
      print(response.body);
      return RegisterResponseModel.fromJson(
        new Map<String, dynamic>.from(
          jsonDecode(response.body),
        ),
      );
    }
  }

  // Fetch Organization Service

  Future<List<Organization>> fetchOrganizations() async {
    String url = "${AppUrl.kBaseUrl}/Organizations";
    var response;

    response = await http.get(Uri.parse(url));
    print("Success" + response.body);
    return organizationFromJson(response.body);
  }

  // Fetch Roles Service

  Future<RoleResponseModel> fetchRoles(
      RoleRequestModel roleRequestModel) async {
    String url = "${AppUrl.kBaseUrl}/roles/getRolesInOrg";

    print("Organization Id: ${roleRequestModel.orgId}");

    var response;

    try {
      response = await http.post(
        Uri.parse(url),
        body: roleRequestModel.toJson(),
      );
      print(response.body);
      return RoleResponseModel.fromJson(
        new Map<String, dynamic>.from(
          jsonDecode(response.body),
        ),
      );
    } catch (e) {
      print(response.body);
      return RoleResponseModel.fromJson(
        new Map<String, dynamic>.from(
          jsonDecode(response.body),
        ),
      );
    }
  }

  // Fetch Poll Service

  Future<Polls> fetchPolls(PollRequestModel pollRequestModel) async {
    print(pollRequestModel.userId);
    String url = "${AppUrl.kBaseUrl}/Polls/getUserPolls/${pollRequestModel.userId}";

    var response;

    try{
      response = await http.get(Uri.parse(url));
      if (response != null){
        print("From request: $response");
        return Polls.fromJson(
          new Map<String, dynamic>.from(
            jsonDecode(response.body)
          )
        );
      } else {
        print("Response is Null: $response");
      }
    } catch (e){
      print("Error: " + response.body);
      if (response != null){
        return Polls.fromJson(
          new Map<String, dynamic>.from(
            jsonDecode(response.body)
          )
        );
      }
    }

    return null;

  }

  // Send account for verification

  Future<VerificationResponseModel> submitAccountForVerification(
      VerificationRequestModel verificationRequestModel) async {
    String url = "${AppUrl.kBaseUrl}/Verifications";
    var response;

    try {
      response = await http.post(
        Uri.parse(url),
        body: verificationRequestModel.toJson(),
      );
      print(response.body);
      if (response != null) {
        return VerificationResponseModel.fromJson(
          new Map<String, dynamic>.from(
            json.decode(response.body),
          ),
        );
      }
    } catch (e) {
      if (response != null) {
        return VerificationResponseModel.fromJson(
          new Map<String, dynamic>.from(
            jsonDecode(response.body),
          ),
        );
      }
    }
    return null;
  }

  // Fetch role detail

  Future<RoleDetailResponseModel> requestRoleDetail(RoleDetailRequestModel roleDetailRequestModel) async{
    String url = "${AppUrl.kBaseUrl}/roles/getRoleDetails";

    var response;

    try{
      response = await http.post(Uri.parse(url), body: roleDetailRequestModel.toJson());
      if (response != null){
        return RoleDetailResponseModel.fromJson(
          new Map<String, dynamic>.from(
            json.decode(response.body),
          )
        );
      }
    } catch (e){
      if(response != null){
        return RoleDetailResponseModel.fromJson(
          new Map<String, dynamic>.from(
            json.decode(response.body)
          )
        );
      }
    }
    return null;
  }

}
