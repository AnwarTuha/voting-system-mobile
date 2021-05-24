import 'package:flutter/material.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';

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
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Poll Title"),
                  SizedBox(height: 10.0),
                  Text("Choose Copy Machine Type", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                  SizedBox(height: 15.0),
                  Text("Type"),
                  SizedBox(height: 10.0),
                  Text("Selection", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                  SizedBox(height: 15.0),
                  Text("Deadline"),
                  SizedBox(height: 10.0),
                  Text("May 24, 2021", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                  SizedBox(height: 15.0),
                  CustomButton(title: "View", onPressed: (){}, enabled: true)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
