import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/providers/poll_provider.dart';
import 'package:voting_system_mobile/screens/poll_detail_screen.dart';

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
