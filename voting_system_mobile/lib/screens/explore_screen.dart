import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/public_poll_model.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/screens/public_poll_detail.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/widgets/no_result_page.dart';
import 'package:voting_system_mobile/widgets/public_poll_card.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  Future futurePolls;
  List<PublicPoll> polls = [];

  @override
  void initState() {
    super.initState();
    futurePolls = _getPublicVotes();
  }

  Future _getPublicVotes() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;

    // prepare request model
    PublicPollRequestModel pollRequestModel = PublicPollRequestModel(
      authenticationToken: userProvider.token,
    );

    // send request to fetch public polls
    await RequestService().requestPublicPolls(pollRequestModel).then((response) {
      polls.addAll(response.polls);
    });

    return polls.distinct((element) => element.pollId).toList();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey _refreshKey = GlobalKey();
    return Container(
      margin: EdgeInsets.all(10.0),
      child: FutureBuilder(
        future: futurePolls,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return Container(
                child: Center(
                  child: NoResultPage(
                    onPressed: () {
                      setState(() {
                        futurePolls = _getPublicVotes();
                      });
                      return futurePolls;
                    },
                  ),
                ),
              );
            }
            return RefreshIndicator(
              key: _refreshKey,
              onRefresh: () {
                setState(() {
                  futurePolls = _getPublicVotes();
                });
                return futurePolls;
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
                child: SpinKitFoldingCube(size: 30.0, color: tealLightColor),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildPollCard(String pollTitle, DateTime endDate, PublicPoll poll) {
    return PublicPollCard(
        pollTitle: pollTitle,
        endDate: endDate,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PublicPollDetail(poll: poll),
            ),
          );
        });
  }
}
