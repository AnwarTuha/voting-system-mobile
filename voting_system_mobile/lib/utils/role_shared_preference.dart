import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_system_mobile/model/role_detail.dart';

class RolePreferences{
  static SharedPreferences _preferences;
  static const String roleDetailKey = "role";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setRoleDetail(RoleDetail roleDetail) async {
    final json =  jsonEncode(roleDetail.toJson());

    await _preferences.setString(roleDetailKey, json);
  }

  static RoleDetail getRoleDetail(){
    final json = _preferences.get(roleDetailKey);

    if (json == null){
      return null;
    }

    return RoleDetail.fromJson(jsonDecode(json));
  }

  static Future removeRoleDetail() async{
    await _preferences.remove(roleDetailKey);
  }

}