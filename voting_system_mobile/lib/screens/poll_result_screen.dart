import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/widgets/progress_hud_modal.dart';
import 'package:voting_system_mobile/model/result_model.dart';

class PollResultsDetail extends StatefulWidget {
  static const String id = "poll_detail";

  final Poll poll;

  PollResultsDetail({this.poll});

  @override
  _PollResultsDetail createState() => _PollResultsDetail();
}

class _PollResultsDetail extends State<PollResultsDetail> {
  bool isApiCallProcess = true;
  List<ResultData> results = [];
  String winner;

  @override
  void initState() {
    super.initState();
    _getResult();
  }

  _checkWinner(List<ResultData> results){
    results.sort((a, b) => a.voteCount.compareTo(b.voteCount));
    winner = results.last.title;
  }

  _getResult(){

    ResultRequestModel requestModel = ResultRequestModel();

    requestModel.pollId = widget.poll.pollId;
    requestModel.userId = Provider.of<UserProvider>(context, listen: false).user.userId;

    RequestService().requestResult(requestModel).then((response) {
      //polls.addAll(response.polls);

      results.addAll(response.result);
      _checkWinner(results);

      setState(() {
        isApiCallProcess = false;
      });

    }).timeout(Duration(seconds: 30), onTimeout: () {
      setState(() {
        isApiCallProcess = false;
      });
      final snackBar =
      SnackBar(content: Text('Request Timed out, Check your connection'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                        "Choices were",
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
                        "Results",
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        "Winner is $winner",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
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
