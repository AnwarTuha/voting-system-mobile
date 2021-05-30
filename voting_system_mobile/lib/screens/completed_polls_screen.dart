import 'package:flutter/material.dart';

class CompletedPoll extends StatefulWidget {
  @override
  _CompletedPollState createState() => _CompletedPollState();
}

class _CompletedPollState extends State<CompletedPoll> with AutomaticKeepAliveClientMixin<CompletedPoll>{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(child: Center(child: Text("Completed Polls"),),);
  }
}
