import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/candidate_poll_model.dart';
import 'package:voting_system_mobile/model/has_voted_model.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/model/vote_model.dart';
import 'package:voting_system_mobile/providers/poll_provider.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
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
  bool userHasVoted;
  Future futureUserHasVoted;
  Future candidateDetails;

  List<Candidate> candidates = [];

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
    if (widget.poll.type == "Candidate") {
      candidateDetails = _getCandidatesDetails();
    }
  }

  Future _getCandidatesDetails() async {
    var userProvider = Provider.of<UserProvider>(context).user;

    CandidateRequestModel candidateRequestModel = CandidateRequestModel(
      voterId: userProvider.userId,
      authenticationToken: userProvider.token,
      pollId: widget.poll.pollId,
    );

    await RequestService()
        .getCandidateDetail(candidateRequestModel)
        .then((response) {
      setState(() {
        candidates = response.response.candidates;
      });
    });

    return candidates;
  }

  Future _checkIfUserVoted() async {
    var userProvider = Provider.of<UserProvider>(context).user;

    UserHasVotedRequestModel requestModel = UserHasVotedRequestModel(
      authenticationToken: userProvider.token,
      userId: userProvider.userId,
      pollId: widget.poll.pollId,
    );

    await RequestService().checkHasUserVoted(requestModel).then((response) {
      setState(() {
        userHasVoted = response.hasVoted;
      });
      //Provider.of<PollProvider>(context, listen: false).setUserHasVoted(widget.poll.pollId);
    });

    return userHasVoted;
  }

  @override
  Widget build(BuildContext context) {
    var pollProvider = Provider.of<PollProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    _showCandidateDetail(Candidate candidate) async {
      return showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              child: Center(
                child: Text(
                  "${candidate.role}",
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
            );
          });
    }

    _voteOnPoll(var choiceList) async {
      String _choice;

      // show options to pick from
      await showDialog(
        context: context,
        builder: (context) {
          return ChoiceModal(
            pollTitle: widget.poll.pollTitle,
            options: choiceList,
          );
        },
      ).then((userChoice) {
        _choice = userChoice;
      });

      // setup request model
      VoteRequestModel voteRequestModel = VoteRequestModel(
        authenticationToken: userProvider.user.token,
        pollId: widget.poll.pollId,
        voterId: userProvider.user.userId,
        option: _choice,
      );

      // send vote on poll request
      await RequestService().voteOnPoll(voteRequestModel).then((response) {
        if (response.response != null) {
          setState(() {
            userHasVoted = true;
            pollProvider.setUserHasVoted(widget.poll.pollId);
          });
        } else {
          final snackBar = SnackBar(
            content: Text('Something went wrong, try again'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Poll Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 8.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${widget.poll.pollTitle}",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 7.0),
                      Text(
                        "${widget.poll.pollDescription}",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 7.0),
                      Divider(color: Colors.grey.shade800),
                      const SizedBox(height: 15.0),
                      Text(
                        "Here are the choices",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 7.0),
                      widget.poll.type == "Candidate"
                          ? FutureBuilder(
                              future: candidateDetails,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: candidates.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        width: double.infinity,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            _showCandidateDetail(
                                                candidates[index]);
                                          },
                                          child: Text(
                                            "${candidates[index].candidateFirstName} ${candidates[index].candidateLastName}",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Container(
                                    child: Center(
                                      child: SpinKitWave(
                                          size: 25.0, color: tealLightColor),
                                    ),
                                  );
                                }
                              },
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.poll.option.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "${widget.poll.option[index].title}",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                      const SizedBox(height: 7.0),
                      Divider(color: Colors.grey.shade800),
                      const SizedBox(height: 15.0),
                      Text(
                        "Important things to note",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 7.0),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            "This poll is of type ${widget.poll.type}",
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 7.0),
                      widget.poll.canRetract
                          ? Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Text(
                                  "You can retract your vote for this poll",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18.0),
                                ),
                              ),
                            )
                          : Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Text(
                                  "You CANNOT retract your vote for this poll",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18.0),
                                ),
                              ),
                            ),
                      const SizedBox(height: 7.0),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 8.0,
                color: Colors.white,
                child: widget.fromClass == "upcoming"
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              "This poll hasn't begun yet",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.0),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder(
                          future: futureUserHasVoted,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              if (snapshot.data == true ||
                                  userHasVoted == true) {
                                pollProvider
                                    .setUserHasVoted(widget.poll.pollId);
                                return Container(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "You've already voted on this poll",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18.0),
                                    ),
                                  ),
                                );
                              } else {
                                return CustomButton(
                                  onPressed: () {
                                    var choiceList =
                                        widget.poll.type == "Candidate"
                                            ? candidates
                                            : widget.poll.option;
                                    _voteOnPoll(choiceList);
                                  },
                                  title: "Click here to vote",
                                  enabled: true,
                                );
                              }
                            } else {
                              return Container(
                                child: Center(
                                  child: SpinKitWave(
                                      size: 25.0, color: tealLightColor),
                                ),
                              );
                            }
                          },
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
