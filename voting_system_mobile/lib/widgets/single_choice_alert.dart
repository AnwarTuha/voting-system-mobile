import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoiceModal extends StatefulWidget {
  final List<String> options;
  final String pollTitle;

  ChoiceModal({this.options, this.pollTitle});

  @override
  _ChoiceModalState createState() => _ChoiceModalState();
}

class _ChoiceModalState extends State<ChoiceModal> {
  String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(widget.pollTitle),
        actions: <Widget>[
          TextButton(
            child: Text("Vote"),
            onPressed: () {
              Navigator.pop(context, selectedValue);
            },
          )
        ],
        content: Center(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("${widget.pollTitle}"),
              ],
            ),
          ),
        ));
  }
}
