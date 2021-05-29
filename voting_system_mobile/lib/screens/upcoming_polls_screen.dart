import 'package:flutter/material.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/screens/poll_detail_screen.dart';
import 'package:voting_system_mobile/widgets/poll_card.dart';
import 'package:voting_system_mobile/widgets/progress_hud_modal.dart';

class UpcomingPoll extends StatefulWidget {

  @override
  _UpcomingPollState createState() => _UpcomingPollState();
}

class _UpcomingPollState extends State<UpcomingPoll> with AutomaticKeepAliveClientMixin<UpcomingPoll> {

  @override
  bool get wantKeepAlive => true;

  List polls = [];
  bool isApiCallProcess = true;

  @override
  void initState() {

    PollRequestModel pollRequestModel = PollRequestModel();

    pollRequestModel.userId = "60a23ccbf779530ab5601a68";

    RequestService().fetchPolls(pollRequestModel).then((response){
      polls.addAll(response.polls);
      setState(() {
        isApiCallProcess = false;
      });
    }).timeout(Duration(seconds: 30), onTimeout: (){
      setState(() {
        isApiCallProcess = false;
      });
      final snackBar = SnackBar(content: Text('Request Timed out, Check your connection'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uiSetup(context), inAsynchCall: isApiCallProcess);
  }

  Widget _uiSetup(BuildContext context) {

    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

    Future _refresh() {

      PollRequestModel pollRequestModel = PollRequestModel();

      pollRequestModel.userId = "60a23ccbf779530ab5601a68";

      return  RequestService().fetchPolls(pollRequestModel).then((response){
        if (response.polls.length != polls.length){
          polls.addAll(response.polls.toSet().toList());
        } else {
          final snackBar = SnackBar(content: Text('No new Polls'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        setState(() {
          isApiCallProcess = false;
        });
      }).timeout(Duration(seconds: 30), onTimeout: (){
        setState(() {
          isApiCallProcess = false;
        });
        final snackBar = SnackBar(content: Text('Request Timed out, Check your connection'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }


    return Container(
      margin: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 10.0),
              polls.length == 0 ?
              Center(child: Text("You have no polls yet.", textAlign: TextAlign.center),):
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: polls.length,
                  itemBuilder: (BuildContext context, int index) {
                    for (var poll in polls)
                      return buildPollCard(poll.pollTitle, poll.endDate, poll);
                    return null;
                  })

            ],
          ),
        ),
      ),
    );
  }

  Widget buildPollCard(String pollTitle, DateTime endDate, Poll poll){
    return PollCard(pollTitle: pollTitle, endDate: endDate,  onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => PollDetail(poll: poll)));
    });
  }

}
