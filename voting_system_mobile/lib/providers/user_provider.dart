import 'dart:io';

import 'package:flutter/material.dart';
import 'package:voting_system_mobile/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  File get userImage => _user.image;

  void setUserImage(File image) {
    _user.image = image;
    notifyListeners();
  }
}
