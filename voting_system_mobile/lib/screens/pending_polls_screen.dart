import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/providers/poll_provider.dart';
import 'package:voting_system_mobile/screens/poll_detail_screen.dart';
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

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Consumer<PollProvider>(
          builder: (_, provider, __) => provider.pendingPolls.length == 0
              ? Center(
                  child: Text("No pending polls yet"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    Poll poll = provider.getPendingPollByIndex(index);
                    return buildPollCard(poll.pollTitle, poll.endDate, poll);
                  },
                  itemCount: provider.pendingPolls.length,
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

}
