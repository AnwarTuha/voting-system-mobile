import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_util.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/header_container.dart';
import 'package:voting_system_mobile/widgets/text_input_container.dart';

import 'login_screen.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'user_registration';

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {

    // temporary roles
    List<String> roles = ['Janitor', 'Secretary', 'President'];

    String dropDownValue = roles.first;

    return Scaffold(
        body: Container(
          padding: EdgeInsets.only(bottom: 30.0),
        child: Column(
        children: <Widget>[
          HeaderContainer(queryHeight: 0.3),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: Column(
                children: <Widget>[
                  TextInput(hintText: "Full Name", icon: Icons.person),
                  TextInput(hintText: "Phone Number", icon: Icons.phone),
                  TextInput(hintText: "Email", icon: Icons.email),
                  TextInput(hintText: "Password", icon: Icons.vpn_key),
                  SizedBox(height: 5.0),
                  const Divider(indent: 2.0, color: Colors.black),
                  DropdownButton<String>(
                    value: dropDownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (value){
                      setState(() {
                        dropDownValue = value;
                      });
                    },
                    items: roles.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem(
                            value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                  Expanded(
                    child: Center(
                        child: CustomButton(
                      title: 'Register',
                      onPressed: () {
                        // Todo: implement register button
                      },
                    )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Already have an account?",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: " Login",
                          style: TextStyle(color: purpleColors))
                    ])),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
