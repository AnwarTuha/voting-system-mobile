import 'package:flutter/material.dart';
import 'package:voting_system_mobile/screens/forgot_password_screen.dart';
import 'package:voting_system_mobile/screens/register_screen.dart';
import 'package:voting_system_mobile/utils/color_util.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/header_container.dart';
import 'package:voting_system_mobile/widgets/text_input_container.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'user_login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(bottom: 30.0),
      child: Column(
        children: <Widget>[
          HeaderContainer(queryHeight: 0.4),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              child: Column(
                children: <Widget>[
                  TextInput(hintText: "Email", icon: Icons.email),
                  TextInput(hintText: "Password", icon: Icons.vpn_key),
                  Container(
                    margin: EdgeInsets.only(top: 25.0),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          // Todo: Implement 'forgot your password' link functionality
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                        },
                        child: Text('Forgot your Password?')),
                  ),
                  Expanded(
                    child: Center(
                      child: CustomButton(title: 'Login', onPressed: (){
                        // Todo: implement login functionality here
                      },)
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationPage()));
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Don't have an account?",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: " Register",
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
