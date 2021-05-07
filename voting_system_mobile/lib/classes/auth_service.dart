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
    final response = await http.post(Uri.parse(url), body: loginRequestModel.toJson());
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(
        new Map<String, dynamic>.from(json.decode(response.body.toString()))
      );
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }

  // Register service
  Future<RegisterResponseModel> register(RegisterRequestModel registerRequestModel) async {
    String url = "$kBaseUrl/register";
    final response =
        await http.post(Uri.parse(url), body: registerRequestModel.toJson());

    if (response.statusCode == 200) {
      return RegisterResponseModel.fromJson(
        new Map<String, dynamic>.from(json.decode(response.body)["user"]),
      );
    } else {
      throw Exception("Failed to Register: ${response.statusCode}");
    }
  }
}
