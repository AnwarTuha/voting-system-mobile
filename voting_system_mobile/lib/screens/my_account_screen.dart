import 'package:flutter/material.dart';
import 'package:voting_system_mobile/model/user_model.dart';
import 'package:voting_system_mobile/widgets/profile_picture_avatar.dart';
import 'package:voting_system_mobile/widgets/text_field_widget.dart';

class MyAccount extends StatefulWidget {

  final User user;
  static const String id = "my_account";

  MyAccount({this.user});

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anwar Tuha", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              ProfilePic(),
              SizedBox(height: 15.0),
              Text("Personal", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              InputTextField(labelText: "First Name"),
              InputTextField(labelText: "Last Name"),
              InputTextField(labelText: "Phone Number"),
              InputTextField(labelText: "Email"),
              SizedBox(height: 10.0),
              Text("Company", style: TextStyle(fontWeight: FontWeight.bold)),
              InputTextField(labelText: "Organization/Company"),
              InputTextField(labelText: "Role"),
              SizedBox(height: 10.0),
              Text("Address", style: TextStyle(fontWeight: FontWeight.bold)),
              InputTextField(labelText: "Country"),
              InputTextField(labelText: "City"),
              InputTextField(labelText: "Street"),
            ],
          ),
        ),
      ),
    );
  }
}
