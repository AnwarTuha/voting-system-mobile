import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/model/user_model.dart';
import 'package:voting_system_mobile/providers/poll_provider.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/screens/my_account_screen.dart';
import 'package:voting_system_mobile/shared%20preferences/role_shared_preference.dart';
import 'package:voting_system_mobile/shared%20preferences/user_shared_preferences.dart';
import 'package:voting_system_mobile/widgets/profile_picture_avatar.dart';
import 'package:voting_system_mobile/widgets/profile_menu.dart';

import 'login_screen.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'profile_page';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin<ProfilePage>{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    User user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 15.0),
          ProfilePic(),
          SizedBox(height: 20.0),
          ProfileMenu(title: "My Account", icon: Icons.person_outline, onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccount(
                user: user
            )));
          }),
          ProfileMenu(title: "Notification", icon: Icons.notifications_none, onPressed: (){}),
          ProfileMenu(title: "Settings", icon: Icons.settings, onPressed: (){}),
          ProfileMenu(title: "Help Center", icon: Icons.help_outline, onPressed: (){}),
          ProfileMenu(title: "Log Out", icon: Icons.logout, onPressed: (){
            UserPreferences.removeUser();
            RolePreferences.removeRoleDetail();
            Provider.of<PollProvider>(context, listen: false).setAllPollsToEmpty();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
          })
        ],
      )
    );
  }
}
