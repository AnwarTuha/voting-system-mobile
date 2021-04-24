import 'package:flutter/material.dart';
import 'package:voting_system_mobile/screens/login_screen.dart';
import 'package:voting_system_mobile/screens/register_screen.dart';
import 'package:voting_system_mobile/screens/splash_screen.dart';

void main() {
  runApp(VotingSystem());
}

class VotingSystem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashPage.id,
      routes: {
        SplashPage.id: (context) => SplashPage(),
        LoginPage.id: (context) => LoginPage(),
        RegistrationPage.id: (context) => RegistrationPage()
      },
    );
  }
}

