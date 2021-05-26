import 'package:flutter/material.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';


class PollDetail extends StatefulWidget {
  static const String id = "poll_detail";

  final String pollTitle;

  PollDetail({this.pollTitle});

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
                "${widget.pollTitle}".toUpperCase(),
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16.0),
              Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque pretium pulvinar lobortis. Morbi finibus cursus purus, eget mattis mauris congue venenatis. Praesent eget fermentum libero, ac luctus leo. Praesent efficitur libero vitae mi pretium, non commodo dolor sollicitudin. Cras varius metus efficitur facilisis ornare. Etiam iaculis dapibus elit, non mollis risus. Phasellus porttitor metus mauris, vitae placerat augue faucibus at. Aenean sed bibendum tellus.", style: TextStyle(height: 1.5, fontSize: 18.0),),
              SizedBox(height: 20.0),
              Container(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Text("Poll Type: General", style: TextStyle(fontSize: 18.0)),
                        Divider(),
                        Text("65% of participants have already voted", style: TextStyle(fontSize: 18.0)),
                        Divider(),
                        Text("Ends in: 10 min", style: TextStyle(fontSize: 18.0))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              CustomButton(onPressed: (){}, enabled: true, title: "Cast Vote")
            ],
          ),
        ),
      ),
    );
  }
}
