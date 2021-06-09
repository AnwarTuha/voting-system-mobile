import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/providers/poll_provider.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/screens/poll_detail_screen.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/widgets/no_result_page.dart';
import 'package:voting_system_mobile/widgets/poll_card.dart';

class PendingPolls extends StatefulWidget {
  const PendingPolls({Key key}) : super(key: key);

  @override
  _PendingPollsState createState() => _PendingPollsState();
}

class _PendingPollsState extends State<PendingPolls>
    with AutomaticKeepAliveClientMixin<PendingPolls> {
  @override
  bool get wantKeepAlive => true;

  Future futurePolls;
  List<Poll> polls = [];

  @override
  void initState() {
    super.initState();
    futurePolls = _getPolls();
  }

  Future _getPolls() async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var pollProvider = Provider.of<PollProvider>(context, listen: false);

    PollRequestModel pollRequestModel = PollRequestModel();
    pollRequestModel.userId = userProvider.user.userId;
    pollRequestModel.authenticationToken = userProvider.user.token;

    await RequestService().fetchPendingPolls(pollRequestModel).then((response) {
      pollProvider.setPendingPolls(response.polls);
      polls = pollProvider.pendingPolls;
    });
    return polls.toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                          return futurePolls = _getPolls();
                        },
                      ),
                    ),
                  );
                }
                return RefreshIndicator(
                  key: _refreshKey,
                  onRefresh: () {
                    return futurePolls = _getPolls();
                  },
                  child: ListView.builder(
                    itemBuilder: (context, i) {
                      print(snapshot.data);
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
            }));
  }

  Widget buildPollCard(String pollTitle, DateTime endDate, Poll poll) {
    return PollCard(
        pollTitle: pollTitle,
        endDate: endDate,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PollDetail(poll: poll, fromClass: "pending")));
        });
  }
}
