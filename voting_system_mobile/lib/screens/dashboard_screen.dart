import 'package:flutter/material.dart';
import 'package:voting_system_mobile/screens/completed_polls_screen.dart';
import 'package:voting_system_mobile/screens/notifications_screen.dart';
import 'package:voting_system_mobile/screens/pending_polls_screen.dart';
import 'package:voting_system_mobile/screens/profile_screen.dart';
import 'package:voting_system_mobile/screens/upcoming_polls_screen.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class DashBoard extends StatefulWidget {
  static const String id = "dash_board";

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>  with SingleTickerProviderStateMixin<DashBoard>{

  String title = "Votion";

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }

  List<Widget> _tabs = [
    Tab(icon: Icon(Icons.home), text: "Home"),
    Tab(icon: Icon(Icons.notifications_active), text: "Notifications"),
    Tab(icon: Icon(Icons.supervised_user_circle), text: "Profile"),
  ];

  List<Widget> _pages = [
    TopTabBar(),
    Notifications(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Votion"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        height: 65.0,
        child: TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          physics: NeverScrollableScrollPhysics(),
          labelColor: tealColors,
          labelStyle: TextStyle(fontSize: 15.0),
          tabs: _tabs,
        ),
      ),
    );
  }
}

class TopTabBar extends StatefulWidget {
  const TopTabBar({Key key}) : super(key: key);

  @override
  _TopTabBarState createState() => _TopTabBarState();
}

class _TopTabBarState extends State<TopTabBar> with SingleTickerProviderStateMixin<TopTabBar>{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose(){
    super.dispose();
    _tabController.dispose();
  }

  List<Widget> _tabs = [
    Tab(text: "Live"),
    Tab(text: "Pending"),
    Tab(text: "Results"),
  ];

  List<Widget> _pages = [
    UpcomingPoll(),
    PendingPolls(),
    CompletedPoll()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          color: tealColors,
          child: TabBar(
            controller: _tabController,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: Colors.white)
            ),
            indicatorColor: Colors.white,
            indicatorWeight: 5.0,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.white,
            tabs: _tabs,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
    );
  }
}

