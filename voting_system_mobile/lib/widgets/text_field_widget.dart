import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class InputTextField extends StatelessWidget {
  final String labelText;
  final String fieldText;
  final bool inputEnabled;
  final Function onChanged;

  InputTextField(
      {this.labelText, this.fieldText, this.inputEnabled, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        key: Key(fieldText),
        initialValue: "$fieldText",
        enabled: inputEnabled,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: tealColors),
          ),
          labelText: "$labelText",
        ),
        onChanged: onChanged,
      ),
    );
  }
}
