import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_system_mobile/model/user_model.dart';

class UserPreferences{

  static SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json =  jsonEncode(user.toJson());
    final userId = user.userId;

    await _preferences.setString(userId, json);
  }

  static User getUser(String userId){
    final json = _preferences.getString(userId);
    return User.fromJson(jsonDecode(json));
  }
}