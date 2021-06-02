import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class NoResultPage extends StatelessWidget {

  static const String id = "no_result";

  final Function onPressed;

  NoResultPage({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 150.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              color: tealLightColor,
              size: 100.0,
            ),
            Text('No Polls Found', style: TextStyle(fontSize: 28.0, color: tealColors),),
            Text('Try Refreshing the page', style: TextStyle(fontSize: 18.0, color: tealLightColor, fontWeight: FontWeight.w400),),
            TextButton(onPressed: onPressed, child: Text("Refresh"))
          ],
        ),
    );
  }
}
