import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class NoResultPage extends StatefulWidget {

  static const String id = "no_result";

  final Function onPressed;

  NoResultPage({this.onPressed});

  @override
  _NoResultPageState createState() => _NoResultPageState();
}

class _NoResultPageState extends State<NoResultPage> {
  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.error,
          color: tealLightColor,
          size: 100.0,
        ),
        Text('No Polls Found', style: TextStyle(fontSize: 28.0, color: tealColors),),
        Text('Try refreshing the page', style: TextStyle(fontSize: 18.0, color: tealLightColor, fontWeight: FontWeight.w400),),
        SizedBox(height: 20.0),
        TextButton(onPressed: widget.onPressed, child: Text("Refresh"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black26), foregroundColor: MaterialStateProperty.all(tealColors)),)
      ],
    );
  }
}
