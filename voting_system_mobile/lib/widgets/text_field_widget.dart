import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class InputTextField extends StatelessWidget {
  final String labelText;
  final String fieldText;
  final bool inputEnabled;
  final Function onChanged;
  final Function validator;

  InputTextField({
    this.labelText,
    this.fieldText,
    this.inputEnabled,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        key: Key(fieldText),
        initialValue: fieldText != null ? "$fieldText" : "",
        enabled: inputEnabled,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: tealColors),
          ),
          labelText: "$labelText",
          labelStyle: TextStyle(color: tealColors),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
