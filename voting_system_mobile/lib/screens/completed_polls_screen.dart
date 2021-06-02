import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/providers/poll_provider.dart';
import 'package:voting_system_mobile/screens/poll_result_screen.dart';
import 'package:voting_system_mobile/widgets/poll_card.dart';

class CompletedPoll extends StatefulWidget {
  @override
  _CompletedPollState createState() => _CompletedPollState();
}

class _CompletedPollState extends State<CompletedPoll>
    with AutomaticKeepAliveClientMixin<CompletedPoll> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Consumer<PollProvider>(
          builder: (_, provider, __) => provider.completedPolls.length == 0
              ? Center(
                  child: Text("No pending polls yet"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    Poll poll = provider.getCompletedPollByIndex(index);
                    return buildPollCard(poll.pollTitle, poll.endDate, poll);
                  },
                  itemCount: provider.completedPolls.length,
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
              MaterialPageRoute(builder: (context) => PollResultsDetail(poll: poll)));
        });
  }
}
