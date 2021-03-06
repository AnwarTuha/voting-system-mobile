import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:voting_system_mobile/model/result_model.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

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
  Future _futureWinner;
  String _winner;
  bool isDraw = false;

  @override
  void initState() {
    super.initState();
    //_futureWinner = _getWinner();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _futureWinner = this._getWinner();
  }

  Future _getWinner() async {
    var userProvider = Provider.of<UserProvider>(context);

    ResultRequestModel requestModel = ResultRequestModel(
      userId: userProvider.user.userId,
      pollId: widget.poll.pollId,
      authenticationToken: userProvider.user.token,
    );

    await RequestService().requestResult(requestModel).then((response) {
      results = response.result;
      response.result.sort((a, b) => a.voteCount.compareTo(b.voteCount));
      if (response.result.last.voteCount == 0) {
        _winner = "Its a Draw!!";
        setState(() {
          isDraw = true;
        });
      } else {
        _winner = response.result.last.title;
      }
    });
    return _winner;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poll Results"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 8.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Visibility(
                        visible: !isDraw,
                        child: Text(
                          "and the Winner is...",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        width: double.infinity,
                        child: FutureBuilder(
                          future: _futureWinner,
                          builder: (context, snapshot) {
                            print("Winner is: ${snapshot.data}");
                            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                              print(snapshot.data);
                              return Column(
                                children: [
                                  Center(
                                    child: Text(
                                      snapshot.data == "Its a Draw!!" ? "Its A Draw!!" : "???? ${snapshot.data} ????",
                                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Divider(
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 7.0,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: results.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Center(
                                        child: Text(
                                          "${results[index].title} has got ${results[index].voteCount} votes",
                                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, height: 2.0),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            } else {
                              return Container(
                                child: Center(
                                  child: SpinKitFoldingCube(size: 30.0, color: tealLightColor),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: 8.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
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
                          height: 2.0,
                        ),
                      ),
                      const SizedBox(height: 7.0),
                      Divider(color: Colors.grey.shade800),
                      const SizedBox(height: 15.0),
                      Text(
                        "Here were the choices",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 7.0),
                      for (var option in widget.poll.option)
                        Container(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              "${option.title}",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 7.0),
                      Divider(color: Colors.grey.shade800),
                      const SizedBox(height: 15.0),
                      Text(
                        "Important things to note",
                        style: TextStyle(
                            fontSize: 22, color: Colors.black, letterSpacing: 2.0, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 7.0),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            "This poll is of type ${widget.poll.type}",
                            style: TextStyle(color: Colors.black, fontSize: 18.0),
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
                                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                                ),
                              ),
                            )
                          : Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "You CANNOT retract your vote for this poll",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 7.0),
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
}
