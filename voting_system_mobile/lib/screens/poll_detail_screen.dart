import 'package:flutter/material.dart';

class PollDetail extends StatefulWidget {
  static const String id = "poll_detail";

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
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Text(
              "Poll Title".toUpperCase(),
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16.0),
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque pretium pulvinar lobortis. Morbi finibus cursus purus, eget mattis mauris congue venenatis. Praesent eget fermentum libero, ac luctus leo. Praesent efficitur libero vitae mi pretium, non commodo dolor sollicitudin. Cras varius metus efficitur facilisis ornare. Etiam iaculis dapibus elit, non mollis risus. Phasellus porttitor metus mauris, vitae placerat augue faucibus at. Aenean sed bibendum tellus.", style: TextStyle(height: 1.5, fontSize: 18.0),),
            SizedBox(height: 20.0),
            Container(
              height: 30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.supervisor_account),
                        SizedBox(width: 5.0),
                        Text("65%")
                      ],
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: Text("General", textAlign: TextAlign.center),
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:<Widget>[
                        Icon(Icons.timer),
                        SizedBox(width: 5.0),
                        Text("in 10 min")
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
