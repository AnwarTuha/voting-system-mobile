import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/has_voted_model.dart';
import 'package:voting_system_mobile/model/public_poll_model.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';

class PublicPollDetail extends StatefulWidget {
  static const String id = "poll_detail";

  final PublicPollResponseModel poll;
  final String fromClass;

  PublicPollDetail({this.poll, this.fromClass});

  @override
  _PublicPollDetailState createState() => _PublicPollDetailState();
}

class _PublicPollDetailState extends State<PublicPollDetail> {
  bool userHasVoted;
  Future futureUserHasVoted;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.fromClass != "upcoming") {
      futureUserHasVoted = this._checkIfUserVoted();
    }
  }

  Future _checkIfUserVoted() async {
    var userProvider = Provider.of<UserProvider>(context).user;

    UserHasVotedRequestModel requestModel = UserHasVotedRequestModel(
        authenticationToken: userProvider.token,
        userId: userProvider.userId,
        pollId: widget.poll.pollId);

    await RequestService().checkHasUserVoted(requestModel).then((response) {
      userHasVoted = response.hasVoted;
    });

    return userHasVoted;
  }

  @override
  Widget build(BuildContext context) {
    //var pollProvider = Provider.of<PollProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Poll Details"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text("Public poll Details"),
        ),
      ),
    );
  }
}
