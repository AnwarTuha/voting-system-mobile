import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_system_mobile/model/user_model.dart';
import 'package:voting_system_mobile/model/user_model.dart';

class UserPreferences{

  static SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async{
    final json = jsonEncode(user.toJson());
    final userId = user.id;

    await _preferences.setString(userId, json);
  }

  static User getUser(String idUser){
    final json = _preferences.getString(idUser);

    return User.fromJson(jsonDecode(json));
  }
}