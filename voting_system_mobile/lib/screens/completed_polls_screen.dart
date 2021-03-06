import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/providers/poll_provider.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/screens/poll_result_screen.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/widgets/no_result_page.dart';
import 'package:voting_system_mobile/widgets/poll_card.dart';

class CompletedPoll extends StatefulWidget {
  @override
  _CompletedPollState createState() => _CompletedPollState();
}

class _CompletedPollState extends State<CompletedPoll> with AutomaticKeepAliveClientMixin<CompletedPoll> {
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

    await RequestService().fetchPolls(pollRequestModel).then((response) {
      pollProvider.setAllPoll(response.polls);
      pollProvider.setCompletedPolls();
      polls = pollProvider.completedPolls;
      print(pollProvider.completedPolls);
    }).timeout(Duration(seconds: 40), onTimeout: () {});
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
                          pollProvider.completedPolls[i].pollTitle,
                          pollProvider.completedPolls[i].endDate,
                          pollProvider.completedPolls[i].type,
                          pollProvider.completedPolls[i],
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => PollResultsDetail(poll: poll)));
        });
  }
}
