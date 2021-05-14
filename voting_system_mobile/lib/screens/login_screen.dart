import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/organization_model.dart';
import 'package:voting_system_mobile/model/user_model.dart';
import 'package:voting_system_mobile/screens/dashboard_screen.dart';
import 'package:voting_system_mobile/screens/forgot_password_screen.dart';
import 'package:voting_system_mobile/screens/register_screen.dart';
import 'package:voting_system_mobile/screens/profile_screen.dart';
import 'package:voting_system_mobile/screens/select_organization_screen.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/header_container.dart';
import 'package:voting_system_mobile/widgets/progress_hud_modal.dart';
import 'package:voting_system_mobile/widgets/text_input_container.dart';
import 'package:voting_system_mobile/classes/validator.dart';
import 'package:voting_system_mobile/model/login_model.dart';

import '../utils/color_palette_util.dart';

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
                          textInputType: TextInputType.emailAddress,
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
                                  TextStyle(color: tealColors, fontSize: 15.0),
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
                              RequestService()
                                  .login(requestModel)
                                  .then((response) {
                                setState(() {
                                  // stop progress indicator
                                  isApiCallProcess = false;
                                });
                                handleRoutes(response);
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Divider(thickness: 1.0, color: tealLightColor),
                        SizedBox(height: 15.0),
                        Text(
                          'or Sign in using...',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: tealColors),
                                  onPressed: () {
                                    // Todo: implement sign in with linkedin
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      FaIcon(FontAwesomeIcons.linkedin),
                                      Text('Linked In')
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 4.0),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: tealColors),
                                    onPressed: () {
                                      // Todo: implement sign in with google
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        FaIcon(FontAwesomeIcons.google),
                                        Text('Google')
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 25.0),
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0)),
                            TextSpan(
                                text: " Sign Up",
                                style: TextStyle(
                                    color: tealColors, fontSize: 15.0))
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

  void handleRoutes(response) {
    if (response.token != "") {
      User user = setUserData(response);
      final snackBar = SnackBar(content: Text('Sign in Successful!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (user.orgId != "") {
        if (user.isComplete != false) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => DashBoard()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
        }
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SelectOrganization(userId: user.userId)));
      }
    } else {
      final snackBar = SnackBar(
          content: Text(
        "Error: ${response.error.message}",
        style: TextStyle(color: Colors.red),
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  User setUserData(response){
    User user = User();

    user.isComplete = response.isComplete;
    user.role = response.role;
    user.userId = response.userId;
    user.phoneNumber = response.phoneNumber;
    user.lastName = response.lastName;
    user.firstName = response.firstName;
    user.email = response.email;
    user.orgId = response.orgId;
    user.token = response.token;
    user.userName = response.userName;

    return user;

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
