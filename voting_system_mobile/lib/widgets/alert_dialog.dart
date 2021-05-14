import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class ShowAlertDialog extends StatelessWidget {

  final String organizationName;
  final BuildContext context;

  ShowAlertDialog({this.organizationName, this.context});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(right: 16.0),
          height: 150.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(75.0),
              bottomLeft: Radius.circular(75.0),
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0)
            )
          ),
          child: Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              CircleAvatar(
                radius: 55.0,
                backgroundColor: Colors.grey.shade200,
                child: Icon(
                  Icons.add_alert,
                  size: 55.0,
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Alert!",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Flexible(
                            child: Text("Have you chosen,\n$organizationName?", style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: ElevatedButton(
                                  child: Text("Yes"),
                                  style: ElevatedButton.styleFrom(primary: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                                  onPressed: (){
                                    Navigator.pop(context, true);
                                  },
                                ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: ElevatedButton(
                                child: Text("No"),
                                style: ElevatedButton.styleFrom(primary: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                                onPressed: (){
                                  Navigator.pop(context, false);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
