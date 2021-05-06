import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:voting_system_mobile/classes/auth_service.dart';
import 'package:voting_system_mobile/classes/user.dart';
import 'package:voting_system_mobile/screens/select_organization_screen.dart';
import 'package:voting_system_mobile/utils/color_util.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/header_container.dart';
import 'package:voting_system_mobile/widgets/text_input_container.dart';
import 'package:voting_system_mobile/classes/validator.dart';
import 'package:http/http.dart' as http;

import 'login_screen.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'user_registration';

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationPage> {
  String _countryCodeInit = 'et';
  String _countryCode = '+251';

  User user = User(email: '', password: '', phoneNumber: '', firstName: '', lastName: '');
  Validator validator = Validator();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _url = "https://localhost:8089/signup";

  String token;

  Future save() async {

    var response =
        await http.post(Uri.http(_url, ""), headers: <String, String>{
      'Context-Type': 'applications/json;charSet=UTF-8'
    }, body: <String, String>{
          'email': user.email,
          'password': user.password,
          'phoneNumber': user.phoneNumber,
          'firstName': user.firstName,
          'lastName': user.lastName
    });

    print(response.body);

    //Todo: Do something with the response
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: 30.0),
        child: Column(
          children: <Widget>[
            HeaderContainer(
              queryHeight: 0.2,
              title: 'Sign Up',
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
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
                                textInputType: TextInputType.name,
                                validate: validator.validateName,
                                onSaved: (firstName) {
                                  user.firstName += firstName;
                                })),
                        Expanded(
                            child: TextInput(
                          hintText: 'Last Name',
                          icon: Icons.person,
                          textInputType: TextInputType.name,
                          validate: validator.validateName,
                          onSaved: (lastName) {
                            user.lastName += lastName;
                          },
                        ))
                      ],
                    ),
                    TextInput(
                      hintText: 'User name',
                      icon: Icons.person,
                      textInputType: TextInputType.name,
                      onSaved: (userName){
                        user.userName = userName;
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: CountryCodePicker(
                            initialSelection: _countryCodeInit,
                            onChanged: (value) {
                              _countryCode = value.dialCode;
                              print(_countryCode);
                            },
                            textStyle: TextStyle(
                              fontSize: 18.0,
                              color: tealColors,
                            ),
                            alignLeft: false,
                            showFlagMain: false,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: TextInput(
                            hintText: "Phone Number",
                            icon: Icons.phone,
                            textInputType: TextInputType.phone,
                            validate: validator.validatePhoneNumber,
                            onSaved: (phoneNumber) {
                              user.phoneNumber = _countryCode + phoneNumber;
                            },
                          ),
                        ),
                      ],
                    ),
                    TextInput(
                      hintText: "Email",
                      icon: Icons.email,
                      textInputType: TextInputType.emailAddress,
                      validate: validator.validateEmail,
                      onSaved: (email) {
                        user.email = email;
                      },
                    ),
                    TextInput(
                      hintText: "Password",
                      obscureText: true,
                      icon: Icons.vpn_key,
                      validate: validator.validatePassword,
                      onSaved: (password) {
                        user.password = password;
                      },
                    ),
                    SizedBox(height: 40.0),
                    Center(
                        child: CustomButton(
                      title: 'Continue',
                      onPressed: () {
                        // Todo: implement register button

                        if (!_formKey.currentState.validate()) {
                          return;
                        }

                        _formKey.currentState.save();

                        AuthService().register(user.email, user.password, user.firstName, user.lastName, user.phoneNumber, user.userName).then((value){
                          print(value);
                        });

                        print(user.firstName);
                        print(user.lastName);
                        print(user.email);
                        print(user.password);
                        print(user.phoneNumber);
                        print(_countryCode);
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
                            text: " Login", style: TextStyle(color: tealColors))
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
