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
  String _email;
  String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String validateEmail(String email){

    /* Validate Email from user input
      :param email: String containing email of the user

      :return bool: true if email is valid, false if it's not
    * */

    email = email.trim();

    String regex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(regex);

    if (email.isEmpty || !regExp.hasMatch(email)){
      return 'Enter a valid email';
    }

    return null;
  }

  String validatePassword(String password){
    /* Validate Password from user input
      :param password: String containing password of the user
    * */

    /* the following regex validates the following
      - Minimum 1 UpperCase
      - Minimum 1 lowerCase
      - Minimum 1 Numeric Number
      - Minimum 1 Special Character
      - Common Allowed Characters ( ! @ # $ & * ~ )
    * */
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(password)){
      return 'Please enter a valid password';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HeaderContainer(queryHeight: 0.4, title: 'Login'),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Form(
                  key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextInput(
                            hintText: "Email",
                            icon: Icons.email,
                            validate: validateEmail,
                            onSaved: (value){
                              _email = value;
                            },
                        ),
                        TextInput(
                            hintText: "Password",
                            icon: Icons.vpn_key,
                            obscureText: true,
                            validate: validatePassword,
                            onSaved: (value){
                              _password = value;
                            },
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25.0),
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              // Todo: Implement 'forgot your password' link functionality
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPassword()),
                            );
                            },
                            child: Text(
                              'Forgot your Password?',
                              style: TextStyle(color: tealColors, fontSize: 18.0),
                        ),
                      ),
                    ),
                        SizedBox(height: 40.0),
                        Center(
                          child: CustomButton(
                            title: 'Login',
                            onPressed: () {
                              // Todo: implement login functionality here
                              if(!_formKey.currentState.validate()){
                                return;
                              }

                              _formKey.currentState.save();

                              print(_email);
                              print(_password);
                            },
                          ),
                        ),
                        SizedBox(height: 75.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                          },
                          child: RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Don't have an account?",
                                      style: TextStyle(color: Colors.black)
                                    ),
                                    TextSpan(
                                      text: " Sign Up",
                                      style: TextStyle(color: tealColors)
                                    )
                                  ])
                          ),
                    )
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
