import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/screens/poll_detail_screen.dart';
import 'package:voting_system_mobile/shared%20preferences/user_shared_preferences.dart';
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

  bool inAsyncCall = false;



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProgressHUD(
        child: _uiSetup(context), inAsynchCall: inAsyncCall);
  }

  Widget _uiSetup(BuildContext context) {



    return Container(
      margin: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: Consumer<PollProvider>(
            builder: (_, provider, __) => inAsyncCall || provider.livePolls.length == 0
                ? Center(
                    child: Text("No live polls yet..."),
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

  Future _refresh() async{

    PollRequestModel pollRequestModel = PollRequestModel();
    pollRequestModel.userId = Provider.of<UserProvider>(context, listen: false).user.userId;

    RequestService().fetchPolls(pollRequestModel).then((response) {
      // set all polls for user

      if (Provider.of<PollProvider>(context, listen: false).allPolls.length != response.polls.length){
        Provider.of<PollProvider>(context, listen: false).setAllPoll(response.polls);
        Provider.of<PollProvider>(context, listen: false).setLivePolls();
        Provider.of<PollProvider>(context, listen: false).setCompletedPolls();
      } else {
        final snackBar = SnackBar(content: Text('No new Polls'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}
