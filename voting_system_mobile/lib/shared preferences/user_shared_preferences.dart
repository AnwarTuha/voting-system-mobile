import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_system_mobile/model/user_model.dart';

class UserPreferences {
  static SharedPreferences _preferences;
  static const String _userKey = "user";

  static Future<SharedPreferences> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_userKey, json);
    print("$json is set");
  }

  static User getUser() {
    final json = _preferences.get(_userKey);

    return json == null ? null : User.fromJson(jsonDecode(json));
  }

  static Future removeUser() async {
    await _preferences.remove(_userKey);
  }
}
