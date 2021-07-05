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

class UpcomingPoll extends StatefulWidget {
  @override
  _UpcomingPollState createState() => _UpcomingPollState();
}

class _UpcomingPollState extends State<UpcomingPoll> with AutomaticKeepAliveClientMixin<UpcomingPoll> {
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

    PollRequestModel pollRequestModel =
        PollRequestModel(userId: userProvider.user.userId, authenticationToken: userProvider.user.token);

    await RequestService().fetchPolls(pollRequestModel).then((response) {
      pollProvider.setAllPoll(response.polls);
      pollProvider.setUpcomingPolls();
      polls = pollProvider.upComingPolls;
      print(pollProvider.upComingPolls);
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
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Container(
                  child: Center(
                    child: NoResultPage(
                      onPressed: () {
                        setState(() {
                          futurePolls = _getPolls();
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
                    futurePolls = _getPolls();
                  });
                  return futurePolls;
                },
                child: Consumer<PollProvider>(
                  builder: (context, pollProvider, _) {
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => const Divider(
                        color: Colors.grey,
                      ),
                      itemBuilder: (context, i) {
                        return buildPollCard(
                          pollProvider.upComingPolls[i].pollTitle,
                          pollProvider.upComingPolls[i].endDate,
                          pollProvider.upComingPolls[i].type,
                          pollProvider.upComingPolls[i],
                        );
                      },
                      itemCount: snapshot.data.length,
                    );
                  },
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: SpinKitFoldingCube(size: 30.0, color: tealLightColor),
                ),
              );
            }
          }),
    );
  }

  Widget buildPollCard(String pollTitle, DateTime endDate, String pollType, Poll poll) {
    return PollCard(
        pollTitle: pollTitle,
        endDate: endDate,
        pollType: pollType,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PollDetail(poll: poll, fromClass: "upcoming")));
        });
  }
}
