import 'package:flutter/material.dart';

class UpcomingPoll extends StatefulWidget {
  @override
  _UpcomingPollState createState() => _UpcomingPollState();
}

class _UpcomingPollState extends State<UpcomingPoll> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Poll Title"),
                  SizedBox(height: 15.0),
                  Text("Type"),
                  SizedBox(height: 15.0)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
