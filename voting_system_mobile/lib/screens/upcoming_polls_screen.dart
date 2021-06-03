import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/providers/poll_provider.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/screens/poll_detail_screen.dart';
import 'package:voting_system_mobile/widgets/poll_card.dart';

class UpcomingPoll extends StatefulWidget {
  @override
  _UpcomingPollState createState() => _UpcomingPollState();
}

class _UpcomingPollState extends State<UpcomingPoll>
    with AutomaticKeepAliveClientMixin<UpcomingPoll> {
  @override
  bool get wantKeepAlive => true;

  bool inAsyncCall = false;

  Future polls;
  List<Poll> pollsFromBack = [];

  PollRequestModel pollRequestModel = PollRequestModel();

  @override
  void initState() {
    super.initState();

    pollRequestModel.userId =
        Provider.of<UserProvider>(context, listen: false).user.userId;
    pollRequestModel.authenticationToken =
        Provider.of<UserProvider>(context, listen: false).user.token;

    //polls = _getPolls();
  }

  _getPolls() async {
    var a = RequestService().fetchPolls(pollRequestModel);

    return a;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        margin: EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: _getPolls(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print(polls.toString());
                return Container(
                  child: Center(
                    child: Text("Fetching Polls..."),
                  ),
                );
              } else {
                print("Snapshot is: ${snapshot.data}");
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: snapshot.data[index].pollTitle,
                    );
                  },
                  itemCount: snapshot.data.length,
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
              MaterialPageRoute(builder: (context) => PollDetail(poll: poll)));
        });
  }

  Future _refresh() async {
    print("refresh is called");

    PollRequestModel pollRequestModel = PollRequestModel();
    pollRequestModel.userId =
        Provider.of<UserProvider>(context, listen: false).user.userId;
    pollRequestModel.authenticationToken =
        Provider.of<UserProvider>(context, listen: false).user.token;

    RequestService().fetchPolls(pollRequestModel).then((response) {
      // set all polls for user

      if (Provider.of<PollProvider>(context, listen: false).allPolls.length !=
          response.polls.length) {
        Provider.of<PollProvider>(context, listen: false)
            .setAllPoll(response.polls);
        Provider.of<PollProvider>(context, listen: false).setLivePolls();
        Provider.of<PollProvider>(context, listen: false).setCompletedPolls();
      } else {
        final snackBar = SnackBar(content: Text('No new Polls'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}
