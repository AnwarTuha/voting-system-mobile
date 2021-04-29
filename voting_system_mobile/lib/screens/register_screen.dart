import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
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

  String _firstName;
  String _lastName;
  String _phoneNumber;
  String _email;
  String _password;
  String _countryCode;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String validateName(String firstName, String lastName){
    String name = firstName + lastName;

    if (name.isEmpty || name.length < 6){
      return 'Please enter a valid email';
    }

    return null;

  }

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

  String validatePhoneNumber(String phoneNumber){

  }



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
            HeaderContainer(queryHeight: 0.3, title: 'Sign Up',),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: TextInput(
                                hintText: 'First Name',
                                icon: Icons.person,
                                onSaved: (value){
                                  _firstName = value;
                                },
                            )
                        ),
                        Expanded(
                            child: TextInput(
                                hintText: 'Last Name',
                                icon: Icons.person,
                                onSaved: (value){
                                  _lastName = value;
                                },
                            )
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                            child: CountryCodePicker(
                              initialSelection: 'et',
                              textStyle: TextStyle(
                                fontSize: 18.0,
                                color: tealColors,
                              ),
                              alignLeft: false,
                              showFlag: false,
                              boxDecoration: BoxDecoration(
                                border: Border.all(color: tealColors, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                            )
                        ),
                        Expanded(
                          flex: 3,
                          child: TextInput(
                              hintText: "Phone Number",
                              icon: Icons.phone,
                              onSaved: (value){
                                _phoneNumber = value;
                              },
                          ),
                        ),
                      ],
                    ),
                    TextInput(
                        hintText: "Email",
                        icon: Icons.email,
                        onSaved: (value){
                          _email = value;
                        },
                    ),
                    TextInput(
                        hintText: "Password",
                        icon: Icons.vpn_key,
                        onSaved: (value){
                          _password = value;
                        },
                    ),
                    SizedBox(height: 5.0),
                    SizedBox(height: 40.0),
                    Center(
                        child: CustomButton(
                      title: 'Continue',
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
              ),
            )
          ],
      ),
    ),
        ));
  }
}
