import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/model/role_detail.dart';
import 'package:voting_system_mobile/model/update_profile_model.dart';
import 'package:voting_system_mobile/model/user_model.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/shared%20preferences/role_shared_preference.dart';
import 'package:voting_system_mobile/shared%20preferences/user_shared_preferences.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/profile_picture_avatar.dart';
import 'package:voting_system_mobile/widgets/progress_hud_modal.dart';
import 'package:voting_system_mobile/widgets/text_field_widget.dart';

class MyAccount extends StatefulWidget {
  final User user;
  static const String id = "my_account";

  MyAccount({this.user});

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  RoleDetailRequestModel requestModel = RoleDetailRequestModel();
  RoleDetail roleDetail = RoleDetail();
  RoleDetail roleDetailFromPreference;

  bool isAsyncCall = true;

  @override
  void initState() {
    roleDetailFromPreference = RolePreferences.getRoleDetail();

    if (roleDetailFromPreference == null) {
      print(widget.user.role);
      requestModel.roleId = widget.user.role;
      requestModel.authenticationToken = widget.user.token;
      RequestService().requestRoleDetail(requestModel).then((response) {
        if (response.error != null) {
          print("Error");
          if (response.error.errorCode == 'AUTHORIZATION_ERROR') {
            print('authorization error');
          }
        } else {
          setState(() {
            isAsyncCall = false;
            roleDetail = response.data;
          });
          RolePreferences.setRoleDetail(roleDetail);
        }
      });
    } else {
      setState(() {
        isAsyncCall = false;
        roleDetail = roleDetailFromPreference;
      });
    }

    super.initState();
  }

  bool inputEnabled = false;
  bool buttonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uiSetup(context), inAsynchCall: isAsyncCall);
  }

  Widget _uiSetup(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context).user;

    String _firstName = widget.user.firstName;
    String _lastName = widget.user.lastName;
    String _phone = widget.user.phoneNumber;

    _updateProfile() async {
      // setup request model
      UpdateProfileRequestModel requestModel = UpdateProfileRequestModel(
        id: widget.user.userId,
        authenticationToken: widget.user.token,
        firstName: _firstName,
        lastName: _lastName,
        phone: _phone,
      );

      // send request
      setState(() {
        isAsyncCall = true;
      });

      await RequestService().updateProfile(requestModel).then((response) {
        setState(() {
          inputEnabled = false;
          buttonEnabled = false;
          isAsyncCall = false;
        });
        UserPreferences.setUser(response.response.user);
        Provider.of<UserProvider>(context, listen: false).setUser(response.response.user);
        print(Provider.of<UserProvider>(context, listen: false).user.token);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("${userProvider.firstName} ${userProvider.lastName}", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  inputEnabled = true;
                  buttonEnabled = true;
                });
              },
              icon: Icon(Icons.edit),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            children: <Widget>[
              ProfilePic(),
              SizedBox(height: 15.0),
              Text(
                "Personal",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              InputTextField(
                labelText: "First Name",
                fieldText: "${widget.user.firstName}",
                inputEnabled: inputEnabled,
                onChanged: (newValue) {
                  _firstName = newValue;
                },
              ),
              InputTextField(
                labelText: "Last Name",
                fieldText: "${widget.user.lastName}",
                inputEnabled: inputEnabled,
                onChanged: (newValue) {
                  _lastName = newValue;
                },
              ),
              InputTextField(
                labelText: "Phone Number",
                fieldText: "${widget.user.phoneNumber}",
                inputEnabled: inputEnabled,
                onChanged: (newValue) {
                  _phone = newValue;
                },
              ),
              InputTextField(labelText: "Email", fieldText: "${widget.user.email}", inputEnabled: false),
              SizedBox(height: 10.0),
              Text(
                "Company",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              InputTextField(
                  labelText: "Organization/company", fieldText: "${roleDetail.orgName}", inputEnabled: false),
              InputTextField(labelText: "Role", fieldText: "${roleDetail.roleName}", inputEnabled: false),
              SizedBox(height: 10.0),
              CustomButton(
                  enabled: buttonEnabled,
                  title: "Update",
                  onPressed: () async {
                    _updateProfile();
                  }),
              SizedBox(
                height: 10.0,
              ),
              TextButton(
                onPressed: () {},
                child: Text("Change Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
