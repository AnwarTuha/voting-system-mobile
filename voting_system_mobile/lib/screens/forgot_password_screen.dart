import 'package:flutter/material.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/header_container.dart';
import 'package:voting_system_mobile/widgets/text_field_widget.dart';
import 'package:voting_system_mobile/classes/validator.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = 'password_reset';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    Validator validate = Validator();
    bool _buttonEnabled = false;

    return Scaffold(
        body: Column(
      children: <Widget>[
        HeaderContainer(queryHeight: 0.25, title: 'Reset Password'),
        Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
          child: Column(
            children: <Widget>[
              InputTextField(
                labelText: "Your Email",
                inputEnabled: true,
                validator: validate.validateEmail,
                onChanged: (email) {
                  print(email);
                  setState(() {
                    _buttonEnabled = true;
                  });
                },
              ),
              SizedBox(
                height: 7.0,
              ),
              Container(
                width: double.infinity,
                height: 50.0,
                child: TextButton(
                  onPressed: () {
                    if (!_buttonEnabled) {
                      return null;
                    } else {}
                  },
                  child: Text(
                    "Send Code to Email",
                    style: TextStyle(color: !_buttonEnabled ? Colors.grey : Colors.teal),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Please Check your email for the code we just sent you",
                style: TextStyle(color: !_buttonEnabled ? Colors.grey : Colors.black),
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(),
              SizedBox(
                height: 7.0,
              ),
              InputTextField(
                labelText: "Code",
                inputEnabled: true,
                onChanged: (email) {
                  print(email);
                },
              ),
              InputTextField(
                labelText: "New Password",
                inputEnabled: true,
                onChanged: (email) {
                  print(email);
                },
              ),
              InputTextField(
                labelText: "Confirm New Password",
                inputEnabled: true,
                onChanged: (email) {
                  print(email);
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              CustomButton(
                title: "Change Password",
                onPressed: () {},
                enabled: true,
              ),
            ],
          ),
        )
      ],
    ));
  }
}
