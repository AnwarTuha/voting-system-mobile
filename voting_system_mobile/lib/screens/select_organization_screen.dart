import 'package:flutter/material.dart';
import 'package:voting_system_mobile/widgets/header_container.dart';

class SelectOrganization extends StatefulWidget {

  static const String id = 'select_organization';

  @override
  _SelectOrganizationState createState() => _SelectOrganizationState();
}

class _SelectOrganizationState extends State<SelectOrganization> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HeaderContainer(
                queryHeight: 0.3,
                title: 'Choose Organization',
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),

              )
            ],
          ),
        ),
      ),
    );
  }
}
