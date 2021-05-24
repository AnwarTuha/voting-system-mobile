import 'package:flutter/material.dart';
import 'package:voting_system_mobile/model/user_model.dart';
import 'package:voting_system_mobile/screens/my_account_screen.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/utils/role_shared_preference.dart';
import 'package:voting_system_mobile/utils/user_shared_preferences.dart';
import 'package:voting_system_mobile/widgets/profile_picture_avatar.dart';
import 'package:voting_system_mobile/widgets/profile_menu.dart';

import 'login_screen.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'profile_page';
  final User user;

  ProfilePage({this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: tealColors,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 15.0),
          ProfilePic(),
          SizedBox(height: 20.0),
          ProfileMenu(title: "My Account", icon: Icons.person_outline, onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccount(user: widget.user)));
          }),
          ProfileMenu(title: "Notification", icon: Icons.notifications_none, onPressed: (){}),
          ProfileMenu(title: "Settings", icon: Icons.settings, onPressed: (){}),
          ProfileMenu(title: "Help Center", icon: Icons.help_outline, onPressed: (){}),
          ProfileMenu(title: "Log Out", icon: Icons.logout, onPressed: (){
            UserPreferences.removeUser();
            RolePreferences.removeRoleDetail();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
          })
        ],
      )
    );
  }
}
