import 'package:flutter/material.dart';
import 'package:voting_system_mobile/model/organization_model.dart';
import 'package:voting_system_mobile/model/roles_model.dart';
import 'package:voting_system_mobile/model/user_model.dart';
import 'package:voting_system_mobile/widgets/custom_button.dart';
import 'package:voting_system_mobile/widgets/profile_picture_avatar.dart';
import 'package:voting_system_mobile/widgets/text_field_widget.dart';

class MyAccount extends StatefulWidget {

  final User user;
  final Organization organization;
  final Role role;
  static const String id = "my_account";

  MyAccount({this.user, this.organization, this.role});

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {

  bool inputEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.user.firstName} ${widget.user.lastName}", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    inputEnabled = true;
                  });
                },
                child: Icon(
                  Icons.edit,
                  size: 26.0,
                ),
              )
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
              Text("Personal", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              InputTextField(labelText: "First Name", fieldText: "${widget.user.firstName}", inputEnabled: inputEnabled,),
              InputTextField(labelText: "Last Name", fieldText: "${widget.user.lastName}", inputEnabled: inputEnabled),
              InputTextField(labelText: "Phone Number", fieldText: "${widget.user.phoneNumber}", inputEnabled: inputEnabled),
              InputTextField(labelText: "Email", fieldText: "${widget.user.email}", inputEnabled: inputEnabled),
              SizedBox(height: 10.0),
              Text("Company", style: TextStyle(fontWeight: FontWeight.bold)),
              InputTextField(labelText: "Organization/company", fieldText: "", inputEnabled: false),
              InputTextField(labelText: "Role", fieldText: "", inputEnabled: false),
              SizedBox(height: 10.0),
              Text("Address", style: TextStyle(fontWeight: FontWeight.bold)),
              InputTextField(labelText: "Country", fieldText: "", inputEnabled: inputEnabled),
              InputTextField(labelText: "City", fieldText: "", inputEnabled: inputEnabled),
              SizedBox(height: 10.0),
              CustomButton(title: "Update", onPressed: (){
                setState(() {
                  inputEnabled = false;
                });
              })
            ],
          ),
        ),
      ),
    );
  }
}
