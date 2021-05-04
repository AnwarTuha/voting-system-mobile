import 'package:flutter/material.dart';
import 'package:voting_system_mobile/classes/user.dart';
import 'package:voting_system_mobile/screens/forgot_password_screen.dart';
import 'package:voting_system_mobile/screens/register_screen.dart';
import 'package:voting_system_mobile/utils/color_util.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/header_container.dart';
import 'package:voting_system_mobile/widgets/text_input_container.dart';
import 'package:voting_system_mobile/classes/validator.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static const String id = 'user_login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {

  String _email;
  String _password;
  String _url = "http://localhost:8089/signin";

  Future save() async {
    var response = await http.post(Uri.http(_url, ""),
        headers: <String, String>{
          'Context-Type': 'applications/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': user.email,
          'password': user.password
        });

    //Todo: Do something with the response

  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  User user = User(email: '', password: '');
  Validator validator = Validator();

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
                            controller: TextEditingController(text: user.email),
                            hintText: "Email",
                            icon: Icons.email,
                            validate: validator.validateEmail,
                            onChanged: (email) {
                              user.email = email;
                            }
                            ),
                        TextInput(
                          hintText: "Password",
                          icon: Icons.vpn_key,
                          obscureText: true,
                          onChanged: (password) {
                            user.password = password;
                          },
                          validate: validator.validatePassword,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25.0),
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()),
                              );
                            },
                            child: Text(
                              'Forgot your Password?',
                              style:
                                  TextStyle(color: tealColors, fontSize: 18.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Center(
                          child: CustomButton(
                            title: 'Login',
                            onPressed: () {
                              // Todo: implement login functionality here
                              if (!_formKey.currentState.validate()) {
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
                                text: " Sign Up",
                                style: TextStyle(color: tealColors))
                          ])),
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
