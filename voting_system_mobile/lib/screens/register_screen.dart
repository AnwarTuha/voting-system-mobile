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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 30.0),
          child: Column(
          children: <Widget>[
            HeaderContainer(queryHeight: 0.3, title: 'Register',),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: TextInput(hintText: 'First Name',icon: Icons.person)
                      ),
                      Expanded(
                          child: TextInput(hintText: 'Last Name',icon: Icons.person)
                      )
                    ],
                  ),
                  TextInput(hintText: "Phone Number", icon: Icons.phone),
                  TextInput(hintText: "Email", icon: Icons.email),
                  TextInput(hintText: "Password", icon: Icons.vpn_key),
                  SizedBox(height: 5.0),
                  const Divider(indent: 2.0, color: Colors.black),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: tealColors)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: dropDownValue,
                        hint: Text("Select your role"),
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        isExpanded: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                        onChanged: (newValue){
                          setState(() {
                            dropDownValue = newValue;
                          });
                        },
                        items: roles.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem(
                                value: value,
                              child: Center(child: Text(value, style: TextStyle(color: Colors.black, fontSize: 18.0))),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Center(
                      child: CustomButton(
                    title: 'Register',
                    onPressed: () {
                      // Todo: implement register button
                    },
                  )),
                  SizedBox(height: 30.0),
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
                          style: TextStyle(color: tealColors))
                    ])),
                  )
                ],
              ),
            )
          ],
      ),
    ),
        ));
  }
}
