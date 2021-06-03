
import 'package:flutter/material.dart';
import 'package:voting_system_mobile/model/user_model.dart';
import 'package:voting_system_mobile/shared%20preferences/user_shared_preferences.dart';

class UserProvider extends ChangeNotifier{
  User _user = User();

  User get user => _user;

  void setUser(User user){
    _user = user;
    UserPreferences.setUser(_user);
    notifyListeners();
  }
}