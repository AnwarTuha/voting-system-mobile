import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_util.dart';

class TextInput extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  TextInput({this.controller, this.hintText, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      padding: EdgeInsets.only(left: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: purpleColors),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: purpleColors),
            ),
            hintText: hintText,
            prefixIcon: Icon(icon)),
      ),
    );
  }
}
