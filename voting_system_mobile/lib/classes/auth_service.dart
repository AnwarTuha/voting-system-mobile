import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voting_system_mobile/model/register_model.dart';
import 'package:voting_system_mobile/model/login_model.dart';
import 'package:voting_system_mobile/utils/constants_util.dart';

class AuthService {
  // Login service
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    String url = "$kBaseUrl/login";
    final response = await http.post(Uri.parse(url), body: loginRequestModel);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  // Register service
  Future<RegisterResponseModel> register(
      RegisterRequestModel registerRequestModel) async {
    String url = "$kBaseUrl/register";
    final response =
        await http.post(Uri.parse(url), body: registerRequestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      return RegisterResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Register');
    }
  }
}
