import 'package:flutter/material.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/model/poll_model.dart';


class PollDetail extends StatefulWidget {
  static const String id = "poll_detail";

  final Poll poll;

  PollDetail({this.poll});

  @override
  _PollDetailState createState() => _PollDetailState();
}

class _PollDetailState extends State<PollDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poll Details"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text(
                "${widget.poll.pollTitle}".toUpperCase(),
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16.0),
              Text("${widget.poll.pollDescription}", style: TextStyle(height: 1.5, fontSize: 18.0),),
              SizedBox(height: 20.0),
              Container(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Poll Type: General", style: TextStyle(fontSize: 18.0)),
                        Divider(),
                        Text("Ends in: 10 min", style: TextStyle(fontSize: 18.0)),
                        Divider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Available options are: ", style: TextStyle(fontSize: 18.0)),
                            Divider(),
                            for (var option in widget.poll.option)
                               Text("${option.title}", style: TextStyle(fontSize: 18.0)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              CustomButton(onPressed: (){
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                                "${widget.poll.pollTitle.toUpperCase()}",
                              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
                            ),
                            Divider(),
                            for (var option in widget.poll.option)
                              ListTile(
                                title: Text("${option.title}"),
                                onTap: () {
                                  option.voteCount += 1;
                                  print("Count is ${option.voteCount}");
                                  Navigator.pop(context, option);
                                },
                              ),
                          ],
                        ),
                      );
                    });
              }, enabled: true, title: "Click here to vote")
            ],
          ),
        ),
      ),
    );
  }

}
