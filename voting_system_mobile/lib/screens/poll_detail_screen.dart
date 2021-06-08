import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/model/user_model.dart';
import 'package:voting_system_mobile/model/vote_model.dart';
import 'package:voting_system_mobile/providers/poll_provider.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/progress_hud_modal.dart';
import 'package:voting_system_mobile/widgets/single_choice_alert.dart';

class PollDetail extends StatefulWidget {
  static const String id = "poll_detail";

  final Poll poll;
  final String fromClass;

  PollDetail({this.poll, this.fromClass});

  @override
  _PollDetailState createState() => _PollDetailState();
}

class _PollDetailState extends State<PollDetail> {
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
  }

  Future<String> showChooseDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ChoiceModal(options: widget.poll.option, pollTitle: widget.poll.pollTitle);
        });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _uiSetup(context), inAsynchCall: isApiCallProcess);
  }

  Widget _uiSetup(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var pollProvider = Provider.of<PollProvider>(context);
    String _authenticationToken = userProvider.user.token;
    bool isButtonEnabled;
    String _selectedOption;


    switch(widget.fromClass){
      case "live":
        isButtonEnabled = false;
        break;
      case "pending":
        isButtonEnabled = true;
        break;
      case "upcoming":
        isButtonEnabled = false;
        break;
    }

    setupRequestModel(String option){
      VoteRequestModel voteRequestModel = VoteRequestModel(voterId: userProvider.user.userId, pollId: widget.poll.pollId, authenticationToken: _authenticationToken, option: option);
      return voteRequestModel;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Poll Details"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 8.0,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${widget.poll.pollTitle.toUpperCase()}",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        "${widget.poll.pollDescription}",
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 8.0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Poll Type",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12.0),
                      _buildChip("general"),
                      _buildChip("non-retractable"),
                      _buildChip("single-choice")
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 8.0,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Available Choices",
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12.0),
                      for (var option in widget.poll.option)
                        Text(
                          "${option.title}",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              widget.fromClass == "upcoming" ? Text("Voting hasn't started yet") : CustomButton(
                title: isButtonEnabled ? "You voted: ${widget.poll.userChoice}" : "Click here to vote",
                enabled: !isButtonEnabled,
                onPressed: () async{
                  await showChooseDialog(context).then((value) => _selectedOption = value);
                  VoteRequestModel voteRequestModel = setupRequestModel(_selectedOption);

                  setState(() {
                    isApiCallProcess = true;
                  });

                  RequestService().voteOnPoll(voteRequestModel).then((response){
                    setState(() {
                      isApiCallProcess = false;
                    });

                    pollProvider.setUserOptionForPoll(_selectedOption, widget.poll.pollId);
                    pollProvider.setUserHasVoted(true, widget.poll.pollId);

                    if (response != null){
                      final snackBar = SnackBar(content: Text('${response.response}'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(content: Text('${response.error.message}'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String title) {
    return Chip(
      avatar: CircleAvatar(
        child: Text(title[0].toUpperCase()),
        backgroundColor: Colors.white,
      ),
      label: Text(
        "$title",
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }
}
