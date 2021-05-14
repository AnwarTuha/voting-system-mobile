import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/widgets/alert_dialog.dart';

class OrganizationCard extends StatelessWidget {
  final String organizationName;
  final String organizationId;
  final String userId;
  final Function onPressed;

  OrganizationCard({this.organizationName, this.organizationId, this.onPressed, this.userId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (BuildContext context) => ShowAlertDialog(organizationName: organizationName));
        print(organizationId);
        print(userId);
      },
      child: Card(
        color: Colors.white,
        elevation: 5.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    organizationName,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 25.0,
                  color: tealColors,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
