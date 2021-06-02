import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final Function validate;
  final Function onSaved;
  final Function onChanged;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType textInputType;

  TextInput(
      {this.controller,
      this.validate,
      this.onSaved,
      this.onChanged,
      this.hintText,
      this.icon,
      this.obscureText,
      this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      padding: EdgeInsets.only(left: 10.0),
      child: TextFormField(
        controller: controller,
        validator: validate,
        onChanged: onChanged,
        onSaved: onSaved,
        keyboardType: textInputType,
        obscureText: obscureText != null ? obscureText : false,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(color: tealColors),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(color: tealColors),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(color: Colors.red),
          ),
          hintText: hintText,
          prefixIcon: Icon(icon, color: tealColors),
        ),
      ),
    );
  }
}
