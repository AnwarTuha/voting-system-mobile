import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class PollCard extends StatelessWidget {

  final String pollTitle;
  final Function onPressed;

  const PollCard({
    Key key,
    this.onPressed,
    this.pollTitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: 10.0),
                Container(
                  child: Expanded(
                    flex: 9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Poll Title"),
                        SizedBox(height: 10.0),
                        Text("$pollTitle", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, letterSpacing: 1.5))
                      ],
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: tealColors,
                )
              ],
            )
        ),
      ),
    );
  }
}