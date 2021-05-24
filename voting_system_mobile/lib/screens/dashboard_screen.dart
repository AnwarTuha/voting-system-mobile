import 'package:flutter/material.dart';
import 'package:voting_system_mobile/model/organization_model.dart';
import 'package:voting_system_mobile/model/roles_model.dart';
import 'package:voting_system_mobile/model/user_model.dart';
import 'package:voting_system_mobile/screens/home_screen.dart';
import 'package:voting_system_mobile/screens/login_screen.dart';
import 'package:voting_system_mobile/screens/notifications_screen.dart';
import 'package:voting_system_mobile/screens/profile_screen.dart';
import 'package:voting_system_mobile/utils/role_shared_preference.dart';
import 'package:voting_system_mobile/utils/user_shared_preferences.dart';

class DashBoard extends StatefulWidget {

  final User user;
  final Organization organization;
  final Role role;
  static const String id = "dash_board";

  DashBoard({this.user, this.role, this.organization});

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  List<Widget> _pages;

  @override
  void initState() {
    _pages = [
      HomeScreen(user: widget.user),
      Notifications(),
      ProfilePage(user: widget.user)
    ];

    print("Dashboard / Firstname: ${widget.user.firstName}");

    super.initState();

  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
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
