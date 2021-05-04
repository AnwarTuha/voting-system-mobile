import 'dart:async';

import 'package:flutter/material.dart';
import 'package:voting_system_mobile/screens/login_screen.dart';
import 'package:voting_system_mobile/utils/color_util.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Timer function will exit splash screen after 4000 milliseconds
    Timer(const Duration(milliseconds: 4000), () {
      Navigator.pushReplacementNamed(context, LoginPage.id);
    });
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
