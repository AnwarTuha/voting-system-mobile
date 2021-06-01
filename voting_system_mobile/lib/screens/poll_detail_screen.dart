import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/providers/poll_provider.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/progress_hud_modal.dart';
import 'package:voting_system_mobile/widgets/single_choice_alert.dart';
import 'package:voting_system_mobile/model/vote_model.dart';

class PollDetail extends StatefulWidget {
  static const String id = "poll_detail";

  final Poll poll;

  PollDetail({this.poll});

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
          return ChoiceModal(
              options: widget.poll.option, pollTitle: widget.poll.pollTitle);
        });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _uiSetup(context), inAsynchCall: isApiCallProcess);
  }

  Widget _uiSetup(BuildContext context) {
    String userId = Provider.of<UserProvider>(context).user.userId;
    String _selectedOption;

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
              CustomButton(
                title: !widget.poll.hasVoted
                    ? "Cast your vote"
                    : "You have chosen $_selectedOption}",
                enabled: !(widget.poll.hasVoted),
                onPressed: () async {
                  _selectedOption = await showChooseDialog(context);

                  if (_selectedOption == null || _selectedOption == "") {
                    final snackBar = SnackBar(
                        content: Text('Please choose from the options'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    VoteRequestModel voteRequestModel = VoteRequestModel(
                        voterId: userId,
                        option: _selectedOption,
                        pollId: widget.poll.pollId);

                    setState(() {
                      isApiCallProcess = true;
                    });

                    RequestService()
                        .voteOnPoll(voteRequestModel)
                        .then((response) {
                      print(response.response);
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response.response != null) {
                        widget.poll.hasVoted = true;
                        Provider.of<PollProvider>(context, listen: false)
                            .setPendingPolls();
                        Provider.of<PollProvider>(context, listen: false)
                            .setHasUserHasVoted(true, widget.poll.pollId);
                        final snackBar =
                            SnackBar(content: Text('${response.response}'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                            content: Text('${response.error.message}'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }).timeout(Duration(seconds: 30), onTimeout: () {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      final snackBar = SnackBar(
                          content:
                              Text('Request Timed out, Check your connection'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  }
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
