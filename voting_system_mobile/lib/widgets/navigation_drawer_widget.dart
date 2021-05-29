import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class NavigationDrawer extends StatelessWidget {

  final padding = EdgeInsets.symmetric(horizontal: 20.0);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.alphaBlend(tealColors, tealLightColor)
      ),
    );
  }
}
