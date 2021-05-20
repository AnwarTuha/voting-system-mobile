import 'package:flutter/material.dart';
import 'package:voting_system_mobile/screens/dashboard_screen.dart';
import 'package:voting_system_mobile/screens/forgot_password_screen.dart';
import 'package:voting_system_mobile/screens/login_screen.dart';
import 'package:voting_system_mobile/screens/profile_screen.dart';
import 'package:voting_system_mobile/screens/register_screen.dart';
import 'package:voting_system_mobile/screens/select_organization_screen.dart';
import 'package:voting_system_mobile/screens/splash_screen.dart';
import 'package:voting_system_mobile/screens/select_role_screen.dart';
import 'package:voting_system_mobile/utils/user_shared_preferences.dart';

import 'model/user_model.dart';

Future<void> main() async {
  // This is the glue that binds the framework to the Flutter engine.
  WidgetsFlutterBinding.ensureInitialized();

  // initialize shared preferences
  await UserPreferences.init();

  runApp(VotingSystem());
}

class VotingSystem extends StatelessWidget {

  final String userId = "";
  final User user = null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashPage.id,
      routes: {
        SplashPage.id: (context) => SplashPage(),
        LoginPage.id: (context) => LoginPage(),
        RegistrationPage.id: (context) => RegistrationPage(),
        ProfilePage.id: (context) => ProfilePage(),
        ForgotPassword.id: (context) => ForgotPassword(),
        SelectOrganization.id: (context) => SelectOrganization(userId: userId),
        SelectRole.id: (context) => SelectRole(),
        DashBoard.id: (context) => DashBoard()
      },
    );
  }
}
