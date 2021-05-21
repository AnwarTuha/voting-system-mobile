import 'package:flutter/material.dart';
import 'package:voting_system_mobile/model/organization_model.dart';
import 'package:voting_system_mobile/model/roles_model.dart';
import 'package:voting_system_mobile/model/user_model.dart';
import 'package:voting_system_mobile/screens/login_screen.dart';
import 'package:voting_system_mobile/utils/role_shared_preference.dart';
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

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Votion"),
      ),
      body: Container(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ${widget.user.userName}'),
            ElevatedButton(onPressed: logOut, child: Text("Log Out"))
          ],
        ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active), label: "Notifications"),
          BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), label: "Profile"),
        ],
        onTap: (index){setState(() {
          _selectedIndex = index;
        });},
      ),
    );
  }

  logOut(){
    UserPreferences.removeUser();
    RolePreferences.removeRoleDetail();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

}
