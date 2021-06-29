import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/public_poll_model.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/progress_hud_modal.dart';

class PublicPollDetail extends StatefulWidget {
  static const String id = "poll_detail";

  final PublicPoll poll;
  final String fromClass;

  PublicPollDetail({this.poll, this.fromClass});

  @override
  _PublicPollDetailState createState() => _PublicPollDetailState();
}

class _PublicPollDetailState extends State<PublicPollDetail> {
  @override
  void initState() {
    super.initState();
  }

  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsynchCall: isApiCallProcess,
    );
  }

  Widget _uiSetup(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context).user;

    Question question;
    bool _submitEnabled = true;
    List<Choice> _choices = [];

    _voteOnPoll(List<Choice> _choices) async {
      // prepare public vote model
      PublicPollVoteModel voteModel = PublicPollVoteModel(
        authenticationToken: userProvider.token,
        pollId: widget.poll.pollId,
        userId: userProvider.userId,
        choices: _choices,
      );

      // send vote request
      RequestService().publicPollVote(voteModel).then((response) {
        setState(() {
          isApiCallProcess = false;
        });
        if (response == null) {
          final snackBar = SnackBar(content: Text('Response is null'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Public Poll Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          padding: EdgeInsets.all(20.0),
          child: Column(
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
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  height: 2.0,
                ),
              ),
              const SizedBox(height: 7.0),
              Divider(color: Colors.grey.shade800),
              const SizedBox(height: 15.0),
              Text(
                "Vote on the following questions",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 7.0),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: widget.poll.questions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Text(
                        "${widget.poll.questions[index].questionTitle}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          height: 2.0,
                        ),
                      ),
                      const SizedBox(height: 7.0),
                      CustomRadioButton(
                        padding: 5.0,
                        elevation: 0.0,
                        absoluteZeroSpacing: false,
                        unSelectedColor: Colors.white,
                        unSelectedBorderColor: Colors.black,
                        buttonLables: widget.poll.questions[index].options
                            .map((e) => e.optionTitle)
                            .toList(),
                        buttonValues: widget.poll.questions[index].options
                            .map((e) => e.optionTitle)
                            .toList(),
                        buttonTextStyle: ButtonTextStyle(
                          selectedColor: Colors.white,
                          unSelectedColor: Colors.black,
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        radioButtonValue: (value) {
                          question = widget.poll.questions[index];
                          Choice choice = Choice(
                            questionIndex: index,
                            choiceIndex: question.options.indexWhere(
                                (element) =>
                                    element.optionTitle == value.toString()),
                          );
                          print(choice.questionIndex);
                          print(choice.choiceIndex);
                          _choices.add(choice);
                          _choices.distinct((element) => element.choiceIndex);
                        },
                        horizontal: true,
                        height: 40.0,
                        autoWidth: true,
                        selectedColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 7.0),
              CustomButton(
                title: "Submit Vote",
                enabled: _submitEnabled,
                onPressed: () {
                  setState(() {
                    isApiCallProcess = true;
                  });
                  _voteOnPoll(_choices);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
