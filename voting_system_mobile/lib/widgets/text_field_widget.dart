import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {

  final String labelText;

  InputTextField({this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "$labelText",
        ),
        onChanged: (input){},
      ),
    );
  }
}

