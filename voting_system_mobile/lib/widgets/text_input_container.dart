import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_util.dart';

class TextInput extends StatelessWidget {

  final Function validate;
  final Function onSaved;
  final Function onChanged;
  final String hintText;
  final IconData icon;
  final bool obscureText;

  TextInput({this.validate, this.onSaved, this.onChanged, this.hintText, this.icon, this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0),),),
      padding: EdgeInsets.only(left: 10.0),
      child: TextFormField(
        validator: validate,
        onSaved: onSaved,
        obscureText: obscureText != null ? obscureText : false,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red)
          ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: tealColors),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: tealColors),
            ),
            hintText: hintText,
            prefixIcon: Icon(icon)
        ),
      ),
    );
  }
}
