import 'package:flutter/material.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/widgets/poll_card.dart';

class UpcomingPoll extends StatefulWidget {
  @override
  _UpcomingPollState createState() => _UpcomingPollState();
}

class _UpcomingPollState extends State<UpcomingPoll> {

  List polls = [];
  bool inAsynchCall = true;

  @override
  void initState() {

    PollRequestModel pollRequestModel = PollRequestModel();

    pollRequestModel.userId = "609471e837b0e11a20b893b8";

    RequestService().fetchPolls(pollRequestModel).then((response) => print(response));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
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
                    onChanged: (input) {
                      // Todo: implement search functionality
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.filter_alt),
                    iconSize: 30.0,
                    onPressed: () {
                      // Todo: implement filter polls
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0),
            polls.length == 0 ?
                Center(child: Text("You have no polls yet.", textAlign: TextAlign.center),):
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: polls.length,
                  itemBuilder: (BuildContext context, int index) {
                      for (var poll in polls)
                        print(poll);
                        return buildPollCard();
              })
          ],
        ),
      ),
    );
  }

  Widget buildPollCard(){
    return PollCard(pollTitle: "", onPressed: (){});
  }

}
