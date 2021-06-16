import 'package:flutter/material.dart';
import 'package:voting_system_mobile/screens/completed_polls_screen.dart';
import 'package:voting_system_mobile/screens/explore_screen.dart';
import 'package:voting_system_mobile/screens/live_polls_screen.dart';
import 'package:voting_system_mobile/screens/notifications_screen.dart';
import 'package:voting_system_mobile/screens/pending_polls_screen.dart';
import 'package:voting_system_mobile/screens/profile_screen.dart';
import 'package:voting_system_mobile/screens/upcoming_polls_screen.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/widgets/data_search.dart';
import 'package:voting_system_mobile/widgets/navigation_drawer_widget.dart';

class DashBoard extends StatefulWidget {
  static const String id = "dash_board";

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin<DashBoard> {
  String title = "Votion";

  int _selectedIndex = 0;

  bool inAsyncCall = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> _tabs = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          size: 25.0,
        ),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.explore,
          size: 25.0,
        ),
        label: 'Explore'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.notifications_active,
          size: 25.0,
        ),
        label: 'Notifications'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.supervised_user_circle,
          size: 25.0,
        ),
        label: 'Profile'),
  ];

  List<Widget> _pages = [
    TopTabBar(),
    ExploreScreen(),
    Notifications(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text("Votion"),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(),
                );
              }),
          IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      child: Center(
                        child: Text("sort"),
                      ),
                    );
                  },
                );
              })
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _tabs,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: tealColors,
        onTap: _onItemTapped,
      ),
    );
  }
}

class TopTabBar extends StatefulWidget {
  const TopTabBar({Key key}) : super(key: key);

  @override
  _TopTabBarState createState() => _TopTabBarState();
}

class _TopTabBarState extends State<TopTabBar>
    with SingleTickerProviderStateMixin<TopTabBar> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  List<Widget> _tabs = [
    Tab(text: "Live"),
    Tab(text: "Upcoming"),
    Tab(text: "Pending"),
    Tab(text: "Results"),
  ];

  List<Widget> _pages = [
    LivePolls(),
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
                borderSide: BorderSide(width: 2.0, color: Colors.white)),
            indicatorColor: Colors.white,
            indicatorWeight: 5.0,
            unselectedLabelColor: Colors.white38,
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
