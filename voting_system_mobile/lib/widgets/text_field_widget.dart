import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {

  final String labelText;
  final String fieldText;
  final bool inputEnabled;

  InputTextField({this.labelText, this.fieldText, this.inputEnabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        initialValue: "$fieldText",
        enabled: inputEnabled,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "$labelText",
        ),
        onChanged: (input){},
      ),
    );
  }
}

