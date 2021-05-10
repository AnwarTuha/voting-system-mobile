import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voting_system_mobile/model/register_model.dart';
import 'package:voting_system_mobile/model/login_model.dart';
import 'package:voting_system_mobile/utils/constants_util.dart';

import '../model/login_model.dart';

class AuthService {
  // Login service
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    String url = "$kBaseUrl/login";
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
    String url = "$kBaseUrl/register";
    var response;
    // final response =
    //     await http.post(Uri.parse(url), body: registerRequestModel.toJson());
    // Map<String, dynamic> mappedResponse = json.decode(response.body)["user"];
    // print("Response from server(Mapped): $mappedResponse");
    // if (response.statusCode == 200) {
    //   return RegisterResponseModel.fromJson(mappedResponse);
    // } else {
    //   throw Exception("Failed to Register: ${response.statusCode}");
    // }

    try{
      response = await http.post(Uri.parse(url), body: registerRequestModel.toJson());
      return RegisterResponseModel.fromJson(
        new Map<String, dynamic>.from(jsonDecode(response.body)["user"])
      );
    } catch (e){
      print(response.body[0]);
      return RegisterResponseModel.fromJson(
        new Map<String, dynamic>.from(jsonDecode(response.body)["error"]["details"]["messages"])
      );
    }

  }
}
