import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class HeaderContainer extends StatelessWidget {
  final double queryHeight;
  final String title;

  HeaderContainer({this.queryHeight, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * queryHeight,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [tealColors, tealLightColor],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Votion',
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
              child: Text(
            title != null ? title : '',
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 2.0,
                fontSize: 35.0,
                fontWeight: FontWeight.w300),
          ))
        ],
      ),
    );
  }
}
