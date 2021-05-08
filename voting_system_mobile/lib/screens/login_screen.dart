import 'package:flutter/material.dart';
import 'package:voting_system_mobile/classes/auth_service.dart';
import 'package:voting_system_mobile/screens/forgot_password_screen.dart';
import 'package:voting_system_mobile/screens/register_screen.dart';
import 'package:voting_system_mobile/utils/color_util.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/header_container.dart';
import 'package:voting_system_mobile/widgets/progress_hud_modal.dart';
import 'package:voting_system_mobile/widgets/text_input_container.dart';
import 'package:voting_system_mobile/classes/validator.dart';
import 'package:voting_system_mobile/model/login_model.dart';

import '../utils/color_util.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'user_login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  //User user = User(email: '', password: '');
  Validator validator = Validator();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  LoginRequestModel requestModel;
  bool isApiCallProcess = false;

  @override
  void initState() {
    requestModel = LoginRequestModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _uiSetup(context), inAsynchCall: isApiCallProcess);
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HeaderContainer(queryHeight: 0.3, title: 'Login'),
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
                          validate: validator.validateEmail,
                          onSaved: (input) {
                            //user.email = email;
                            requestModel.email = input;
                          },
                        ),
                        TextInput(
                          hintText: "Password",
                          icon: Icons.vpn_key,
                          obscureText: true,
                          onSaved: (input) {
                            //user.password = password;
                            requestModel.password = input;
                          },
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
                              if (validateAndSave()) {
                                setState(() {
                                  isApiCallProcess = true;
                                });
                              }

                              // authenticate user
                              AuthService()
                                  .login(requestModel)
                                  .then((response) {
                                setState(() {
                                  // stop progress indicator
                                  isApiCallProcess = false;
                                });
                                if (response.user.isNotEmpty) {
                                  final snackBar = SnackBar(
                                    content: Text('Sign in Successful!'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                } else {
                                  final snackBar = SnackBar(
                                    content: Text("Error: ${response.user}"),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Divider(thickness: 2.0),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                  onPressed: (){
                                // Todo: implement sign in with linkedin
                              },
                                child: Row(
                                  children: <Widget>[
                                    Text('Linked In')
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                onPressed: (){
                                  // Todo: implement sign in with google
                                },
                                child: Row(
                                  children: <Widget>[
                                    Text('Google')
                                  ],
                                ),
                              ),
                            )
                          ],
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

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
