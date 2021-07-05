import 'package:flutter/material.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/text_field_widget.dart';

class ChangePassword extends StatefulWidget {
  static const String id = "change_password";

  const ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            InputTextField(
              labelText: "Old Password",
              inputEnabled: true,
              onChanged: (password) {
                print(password);
              },
            ),
            InputTextField(
              labelText: "New Password",
              inputEnabled: true,
              onChanged: (password) {
                print(password);
              },
            ),
            InputTextField(
              labelText: "Confirm New Password",
              inputEnabled: true,
              onChanged: (password) {
                print(password);
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            CustomButton(
              title: "Change Password",
              onPressed: () {
                if (!isButtonEnabled) {
                  return null;
                } else {
                  //
                }
              },
              enabled: isButtonEnabled,
            ),
          ],
        ),
      ),
    );
  }
}
