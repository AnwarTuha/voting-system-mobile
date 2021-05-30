import 'package:flutter/material.dart';

class PendingPolls extends StatefulWidget {
  const PendingPolls({Key key}) : super(key: key);

  @override
  _PendingPollsState createState() => _PendingPollsState();
}

class _PendingPollsState extends State<PendingPolls> with AutomaticKeepAliveClientMixin<PendingPolls>{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Search Polls",
                    ),
                    onChanged: (input){
                      // Todo: implement search functionality
                    },
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.filter_alt),
                      iconSize: 30.0,
                      onPressed: (){
                        //Todo: implement filter
                      },
                    ))
              ],
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
