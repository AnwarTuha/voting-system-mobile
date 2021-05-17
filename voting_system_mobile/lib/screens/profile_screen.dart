import 'package:flutter/material.dart';
import 'package:voting_system_mobile/widgets/profile_picture_avatar.dart';
import 'package:voting_system_mobile/widgets/profile_menu.dart';

class ProfilePage extends StatefulWidget {

  static const String id = 'profile_page';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          ProfilePic(),
          SizedBox(height: 20.0),
          ProfileMenu(title: "My Account", icon: Icons.person_outline, onPressed: (){}),
          ProfileMenu(title: "Notification", icon: Icons.notifications_none, onPressed: (){}),
          ProfileMenu(title: "Settings", icon: Icons.settings, onPressed: (){}),
          ProfileMenu(title: "Help Center", icon: Icons.help_outline, onPressed: (){}),
          ProfileMenu(title: "Log Out", icon: Icons.logout, onPressed: (){})
        ],
      )
    );
  }
}
