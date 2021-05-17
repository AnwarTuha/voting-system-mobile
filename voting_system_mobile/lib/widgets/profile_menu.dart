import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class ProfileMenu extends StatelessWidget {

  final String title;
  final IconData icon;
  final Function onPressed;

  ProfileMenu({@required this.title, @required this.icon, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Color(0xFFFFFFFF),
            elevation: 2.0,
            padding: EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))
        ),
        onPressed: onPressed,
        child: Row(
          children: <Widget>[
            Icon(icon, size: 22.0, color: tealColors),
            SizedBox(width: 20.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade800),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: tealColors)
          ],
        ),
      ),
    );
  }
}