import 'package:flutter/material.dart';
import 'package:voting_system_mobile/model/organization_model.dart';
import 'package:voting_system_mobile/model/roles_model.dart';
import 'package:voting_system_mobile/model/user_model.dart';
import 'package:voting_system_mobile/screens/login_screen.dart';
import 'package:voting_system_mobile/utils/user_shared_preferences.dart';

class DashBoard extends StatefulWidget {

  final User user;
  final Organization organization;
  final Role role;
  static const String id = "dash_board";

  DashBoard({this.user, this.role, this.organization});
  printName() => print(user.firstName);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ${widget.user.userName}'),
            ElevatedButton(onPressed: logOut, child: Text("Log Out"))
          ],
        )),
      ),
    );
  }

  logOut(){
    UserPreferences.removeUser();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

}
