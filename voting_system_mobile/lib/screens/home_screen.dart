import 'package:flutter/material.dart';
import 'package:voting_system_mobile/model/organization_model.dart';
import 'package:voting_system_mobile/model/roles_model.dart';
import 'package:voting_system_mobile/model/user_model.dart';
import 'package:voting_system_mobile/screens/completed_polls_screen.dart';
import 'package:voting_system_mobile/screens/pending_polls_screen.dart';
import 'package:voting_system_mobile/screens/upcoming_polls_screen.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/shared%20preferences/role_shared_preference.dart';
import 'package:voting_system_mobile/shared%20preferences/user_shared_preferences.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {

  final User user;
  final Organization organization;
  final Role role;

  static const String id = "home_screen";

  HomeScreen({this.user, this.role, this.organization});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  final _kTabPages = <Widget>[
    UpcomingPoll(),
    PendingPolls(),
    CompletedPoll()
  ];

  final _kTabs = <Tab>[
    const Tab(text: "Live"),
    const Tab(text: "Pending"),
    const Tab(text: "Results")
  ];

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: _kTabs.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: tealColors,
              child: TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 0.0)
                ),
                indicatorColor: Colors.white,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.white,
                tabs: _kTabs,
              ),
            ),
          ),
          body: TabBarView(
            children: _kTabPages,
          ),
        ),
      );
  }

  logOut(){
    UserPreferences.removeUser();
    RolePreferences.removeRoleDetail();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

}
