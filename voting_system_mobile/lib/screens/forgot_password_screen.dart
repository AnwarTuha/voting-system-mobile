import 'package:flutter/material.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/header_container.dart';
import 'package:voting_system_mobile/widgets/text_input_container.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = 'password_reset';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        HeaderContainer(queryHeight: 0.4, title: 'Reset Password'),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
            child: Column(
              children: <Widget>[
                TextInput(
                  icon: Icons.email,
                  hintText: 'Email',
                ),
                SizedBox(height: 20.0),
                CustomButton(
                  enabled: true,
                  onPressed: () {
                    // Todo: Send password reset link here
                  },
                  title: 'Send Password Reset link',
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
