import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/model/user_model.dart';
import 'package:voting_system_mobile/screens/dashboard_screen.dart';
import 'package:voting_system_mobile/screens/login_screen.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/shared%20preferences/user_shared_preferences.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser(){
    // Get user data if there is any
    User user = UserPreferences.getUser();

    if (user != null){
      if (user.orgId == null || user.orgId == ""){
        UserPreferences.removeUser();
        Timer(const Duration(milliseconds: 4000), (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
        });
      } else {
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        Timer(const Duration(milliseconds: 4000), (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoard()));
        });
      }
    } else {
      Timer(const Duration(milliseconds: 4000), () {
        Navigator.pushReplacementNamed(context, LoginPage.id);
      }
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [tealColors, tealLightColor],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
        ),
        child: Center(
          child: Text(
            'Votion',
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
                fontSize: 75.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
