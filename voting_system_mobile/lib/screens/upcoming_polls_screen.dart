import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/poll_card.dart';

class UpcomingPoll extends StatefulWidget {

  @override
  _UpcomingPollState createState() => _UpcomingPollState();
}

class _UpcomingPollState extends State<UpcomingPoll> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          PollCard(pollTitle: "Choose copier type", onPressed: (){}),
          PollCard(pollTitle: "Should we get a new coffee machine?", onPressed: (){}),
          PollCard(pollTitle: "Approve/deny corporate name change", onPressed: (){}),
          PollCard(pollTitle: "Choose copier type", onPressed: (){}),
          PollCard(pollTitle: "Choose copier type", onPressed: (){}),
        ],
      ),
    );
  }
}


