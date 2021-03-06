import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/register_model.dart';
import 'package:voting_system_mobile/screens/select_organization_screen.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/header_container.dart';
import 'package:voting_system_mobile/widgets/progress_hud_modal.dart';
import 'package:voting_system_mobile/widgets/text_input_container.dart';
import 'package:voting_system_mobile/classes/validator.dart';

import 'login_screen.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'user_registration';

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationPage> {
  String _countryCodeInit = 'et';
  String _countryCode = '+251';
  String _confirm = '';

  Validator validator = Validator();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  RegisterRequestModel requestModel;
  bool isApiCallprocess = false;

  @override
  void initState() {
    requestModel = RegisterRequestModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _uiSetup(context),
        inAsynchCall: isApiCallprocess,
    );
  }

  Widget _uiSetup(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
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
                  child: Expanded(
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
                                onSaved: (input) {
                                  //user.firstName += input;
                                  requestModel.firstName = input;
                                },
                              ),
                            ),
                            Expanded(
                              child: TextInput(
                                hintText: 'Last Name',
                                icon: Icons.person,
                                textInputType: TextInputType.name,
                                validate: validator.validateName,
                                onSaved: (input) {
                                  //user.lastName += lastName;
                                  requestModel.lastName = input;
                                },
                              ),
                            )
                          ],
                        ),
                        TextInput(
                          hintText: 'User name',
                          icon: Icons.person,
                          textInputType: TextInputType.name,
                          onSaved: (input) {
                            //user.userName = userName;
                            requestModel.userName = input;
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
                                onSaved: (input) {
                                  //user.phoneNumber = _countryCode + phoneNumber;
                                  requestModel.phoneNumber = _countryCode + input;
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
                          onSaved: (input) {
                            //user.email = email;
                            requestModel.email = input;
                          },
                        ),
                        TextInput(
                          hintText: "Password",
                          obscureText: true,
                          icon: Icons.vpn_key,
                          validate: validator.validatePassword,
                          onChanged: (input){
                            _confirm = input;
                            print("Password: "+_confirm);
                          },
                          onSaved: (input) {
                            //user.password = password;
                            requestModel.password = input;
                          },
                        ),
                        TextInput(
                          hintText: "Confirm Password",
                          obscureText: true,
                          icon: Icons.vpn_key_outlined,
                          validate: (input){
                            print("Confirm Password: "+_confirm);
                            if (input != _confirm){
                              return "Passwords Don't Match";
                            }
                            return null;
                          }
                        ),
                        SizedBox(height: 30.0),
                        Center(
                            child: CustomButton(
                              enabled: true,
                          title: 'Continue',
                          onPressed: () {
                            if (validateAndSave()) {
                              setState(() {
                                // start progress indicator
                                isApiCallprocess = true;
                              });

                              RequestService()
                                  .register(requestModel)
                                  .then((response) {
                                setState(() {
                                  // stop progress indicator
                                  isApiCallprocess = false;
                                });

                                if (response.user != null) {
                                  final snackBar = SnackBar(
                                    content: Text('Sign up Successful!'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SelectOrganization(userId: response.user.userId)));
                                } else {
                                  showError(response);
                                }
                              });
                            }
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showError(RegisterResponseModel response){
    SnackBar snackBar;
    if (response.error.errorDetails.codes.userName != null){
      snackBar = SnackBar(
        content: Text(
          "Error: User name is not available",
        ),
      );
    } else if(response.error.errorDetails.codes.email != null){
      snackBar = SnackBar(
        content: Text(
          "Error: Email is not available"
        ),
      );
    } else {
      snackBar = SnackBar(
        content: Text(
            "Error: ${response.error.errorMessage}"
        ),
      );
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar);
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
