import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/poll_card.dart';
import 'package:voting_system_mobile/widgets/text_input_container.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 8,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Search Polls",
                    ),
                    onChanged: (input){
                      // Todo: implement search functionality
                    },
                  ),
              ),
              Expanded(
                flex: 1,
               child: IconButton(
                icon: Icon(Icons.filter_alt),
                iconSize: 30.0,
                onPressed: (){
                  //Todo: implement filter
                },
              ))
            ],
          ),
          SizedBox(height: 10.0),
          PollCard(pollTitle: "Choose copier type", onPressed: (){}),
          PollCard(pollTitle: "Should we get a new coffee machine?", onPressed: (){}),
          PollCard(pollTitle: "Approve/deny corporate name change", onPressed: (){}),
          PollCard(pollTitle: "What should we get for Feven", onPressed: (){}),
        ],
      ),
    );
  }

}


