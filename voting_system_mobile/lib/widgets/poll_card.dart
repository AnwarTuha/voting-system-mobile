import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:intl/intl.dart';

class PollCard extends StatelessWidget {

  final String pollTitle;
  final DateTime endDate;
  final Function onPressed;

  const PollCard({
    Key key,
    this.onPressed,
    this.endDate,
    this.pollTitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final DateTime date = endDate;
    final DateFormat formatter = DateFormat('EEE, MMM d, ''yyyy');
    final String formattedDate = formatter.format(date);

    return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: Container(
            padding: EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: 10.0),
                Container(
                  child: Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("$pollTitle", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, letterSpacing: 1.5)),
                        SizedBox(height: 10.0),
                        Text("End Date: $formattedDate")
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