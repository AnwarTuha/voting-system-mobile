import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/screens/poll_detail_screen.dart';
import 'package:voting_system_mobile/widgets/poll_card.dart';
import 'package:voting_system_mobile/widgets/progress_hud_modal.dart';
import 'package:voting_system_mobile/providers/poll_provider.dart';

class UpcomingPoll extends StatefulWidget {
  @override
  _UpcomingPollState createState() => _UpcomingPollState();
}

class _UpcomingPollState extends State<UpcomingPoll> with AutomaticKeepAliveClientMixin<UpcomingPoll> {

  @override
  bool get wantKeepAlive => true;

  List polls = [];
  bool isApiCallProcess = true;

  _getPolls() async {
    var provider = Provider.of<PollProvider>(context, listen: false);

    PollRequestModel pollRequestModel = PollRequestModel();
    pollRequestModel.userId = "60a23ccbf779530ab5601a68";

    RequestService().fetchPolls(pollRequestModel).then((response) {
      //polls.addAll(response.polls);

      provider.setAllPoll(response.polls);
      provider.setLivePolls();

      setState(() {
        isApiCallProcess = false;
      });
    }).timeout(Duration(seconds: 30), onTimeout: () {
      setState(() {
        isApiCallProcess = false;
      });
      final snackBar =
          SnackBar(content: Text('Request Timed out, Check your connection'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  void initState() {
    super.initState();
    _getPolls();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProgressHUD(
        child: _uiSetup(context), inAsynchCall: isApiCallProcess);
  }

  Widget _uiSetup(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Consumer<PollProvider>(
          builder: (_, provider, __) => isApiCallProcess
              ? Center(
                  child: Text("Fetching Polls..."),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    Poll poll = provider.getLivePollByIndex(index);
                    return buildPollCard(poll.pollTitle, poll.endDate, poll);
                  },
                  itemCount: provider.livePolls.length,
                ),
        ),
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

  Future _refresh() {
    PollRequestModel pollRequestModel = PollRequestModel();

    pollRequestModel.userId = "60a23ccbf779530ab5601a68";

    return RequestService().fetchPolls(pollRequestModel).then((response) {

      var provider = Provider.of<PollProvider>(context, listen: false);

      if (response.polls.length != polls.length) {
        provider.setAllPoll(response.polls);
        provider.setLivePolls();
      } else {
        final snackBar = SnackBar(content: Text('No new Polls'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      setState(() {
        isApiCallProcess = false;
      });
    }).timeout(Duration(seconds: 30), onTimeout: () {
      setState(() {
        isApiCallProcess = false;
      });
      final snackBar =
          SnackBar(content: Text('Request Timed out, Check your connection'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
