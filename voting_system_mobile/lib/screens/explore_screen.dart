import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/public_poll_model.dart';
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
  List<PublicPollResponseModel> polls = [];

  @override
  void initState() {
    super.initState();
    futurePolls = _getPublicVotes();
  }

  _getPublicVotes() async {
    await RequestService().requestPublicPoll().then((response) {
      polls.addAll(response.toList());
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
                setState(() {
                  futurePolls = _getPublicVotes();
                });
                return futurePolls;
              },
              child: ListView.builder(
                itemBuilder: (context, i) {
                  return buildPollCard(snapshot.data[i].pollTitle,
                      snapshot.data[i].endDate, snapshot.data[i]);
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

  Widget buildPollCard(
      String pollTitle, DateTime endDate, PublicPollResponseModel poll) {
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
