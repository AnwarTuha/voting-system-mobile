import 'package:flutter/material.dart';
import 'package:voting_system_mobile/model/public_poll_model.dart';

class PublicPollDetail extends StatefulWidget {
  static const String id = "poll_detail";

  final PublicPollResponseModel poll;
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
