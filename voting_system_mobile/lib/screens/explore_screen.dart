import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/model/public_poll_model.dart';
import 'package:voting_system_mobile/screens/poll_detail_screen.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/widgets/no_result_page.dart';
import 'package:voting_system_mobile/widgets/poll_card.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  Future futurePolls;
  List<PublicPollResponseModel> polls = [];

  @override
  void initState() {
    super.initState();
    futurePolls = _getPublicVotes();
  }

  _getPublicVotes() async {
    await RequestService().requestPublicPoll().then((response) {
      polls.addAll(response.toSet().toList());
    });
    return polls;
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey _refreshKey = GlobalKey();
    return Container(
      margin: EdgeInsets.all(10.0),
      child: FutureBuilder(
        future: futurePolls,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: NoResultPage(
                    onPressed: () {
                      return futurePolls = _getPublicVotes();
                    },
                  ),
                ),
              );
            }
            return RefreshIndicator(
              key: _refreshKey,
              onRefresh: () {
                return futurePolls = _getPublicVotes();
              },
              child: ListView.builder(
                itemBuilder: (context, i) {
                  return buildPollCard(snapshot.data[i].pollTitle, snapshot.data[i].endDate, snapshot.data[i]);
                },
                itemCount: snapshot.data.length,
              ),
            );
          } else {
            return Container(
              child: Center(
                child: SpinKitWave(size: 25.0, color: tealLightColor),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildPollCard(String pollTitle, DateTime endDate, Poll poll) {
    return PollCard(
        pollTitle: pollTitle,
        endDate: endDate,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PollDetail(poll: poll)));
        });
  }
}
