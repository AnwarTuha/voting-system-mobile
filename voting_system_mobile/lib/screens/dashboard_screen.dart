import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/providers/poll_provider.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/screens/completed_polls_screen.dart';
import 'package:voting_system_mobile/screens/notifications_screen.dart';
import 'package:voting_system_mobile/screens/pending_polls_screen.dart';
import 'package:voting_system_mobile/screens/poll_detail_screen.dart';
import 'package:voting_system_mobile/screens/profile_screen.dart';
import 'package:voting_system_mobile/screens/upcoming_polls_screen.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/navigation_drawer_widget.dart';

class DashBoard extends StatefulWidget {
  static const String id = "dash_board";

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin<DashBoard> {
  String title = "Votion";

  TabController _tabController;

  bool inAsyncCall = true;

  @override
  void initState() {
    super.initState();
    //_getPolls();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  _getPolls() async {
    // setup request model
    PollRequestModel pollRequestModel = PollRequestModel();
    pollRequestModel.userId =
        Provider.of<UserProvider>(context, listen: false).user.userId;
    pollRequestModel.authenticationToken =
        Provider.of<UserProvider>(context, listen: false).user.token;

    // make request
    RequestService().fetchPolls(pollRequestModel).then((response) {
      // set all polls for user
      if (response.error != null) {
        if (response.error.errorCode == 'AUTHORIZATION_REQUIRED') {
          showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              isDismissible: false,
              backgroundColor: Colors.white,
              builder: (context) {
                return SingleChildScrollView(
                  child: Container(
                    height: 300,
                    margin: EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          const Text(
                            'Please provide a password to continue',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2.0),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: tealColors),
                              ),
                              labelText: "Password",
                            ),
                          ),
                          SizedBox(height: 40.0),
                          CustomButton(
                              title: "Continue",
                              enabled: true,
                              onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
        print('Error while fetching polls');
        setState(() {
          inAsyncCall = false;
        });
      } else {
        Provider.of<PollProvider>(context, listen: false)
            .setAllPoll(response.polls);
        Provider.of<PollProvider>(context, listen: false).setLivePolls();
        Provider.of<PollProvider>(context, listen: false).setCompletedPolls();
        setState(() {
          inAsyncCall = false;
        });
      }
    });
  }

  List<Widget> _tabs = [
    Tab(icon: Icon(Icons.home), text: "Home"),
    Tab(icon: Icon(Icons.notifications_active), text: "Notifications"),
    Tab(icon: Icon(Icons.supervised_user_circle), text: "Profile"),
  ];

  List<Widget> _pages = [TopTabBar(), Notifications(), ProfilePage()];

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
          IconButton(icon: Icon(Icons.filter_list), onPressed: () {})
        ],
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

class _TopTabBarState extends State<TopTabBar>
    with SingleTickerProviderStateMixin<TopTabBar> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  List<Widget> _tabs = [
    Tab(text: "Live"),
    Tab(text: "Pending"),
    Tab(text: "Results"),
  ];

  List<Widget> _pages = [UpcomingPoll(), PendingPolls(), CompletedPoll()];

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

class DataSearch extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Search Polls';

  bool get maintainState => true;

  final polls = [];
  var indexGlobal;

  final recentPolls = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar

    polls.addAll(Provider.of<PollProvider>(context).allPolls);

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on selection
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show suggestions while typing search
    final suggestionList = query.isEmpty
        ? recentPolls
        : polls
            .where((element) =>
                element.pollTitle.toUpperCase().startsWith(query.toUpperCase()))
            .toSet()
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          recentPolls.add(polls[index]);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PollDetail(poll: polls[index])));
        },
        leading: Icon(Icons.poll),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].pollTitle.substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestionList[index].pollTitle.substring(query.length),
                  style: TextStyle(color: Colors.grey),
                )
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
