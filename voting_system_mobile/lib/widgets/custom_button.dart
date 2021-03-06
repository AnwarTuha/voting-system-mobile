import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final bool enabled;

  CustomButton({this.onPressed, this.title, this.enabled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 45.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: enabled ? [tealColors, tealLightColor] : [Colors.grey, Colors.grey],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0),
        ),
      ),
    );
  }
}
