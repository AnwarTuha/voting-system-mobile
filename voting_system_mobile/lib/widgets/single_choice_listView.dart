import 'package:flutter/cupertino.dart';
import 'package:voting_system_mobile/model/poll_model.dart';
import 'package:flutter/material.dart';

class ChoiceModal extends StatefulWidget {
  final List<Option> options;

  ChoiceModal({this.options});

  @override
  _ChoiceModalState createState() => _ChoiceModalState();
}

class _ChoiceModalState extends State<ChoiceModal> {
  String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.options.first.title;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[TextButton(child: Text("Vote"), onPressed: (){Navigator.pop(context, selectedValue);},)],
      content: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.options
                .map(
                  (e) => RadioListTile(
                title: Text(e.title),
                value: e.title,
                groupValue: selectedValue,
                selected: selectedValue == e.title,
                onChanged: (newValue){
                  setState(() {
                    selectedValue = newValue;
                  });
                },
              ),
            ).toList(),
          )
      ),
    );
  }
}
