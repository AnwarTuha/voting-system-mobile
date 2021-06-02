import 'package:flutter/material.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/widgets/alert_dialog.dart';
import 'package:voting_system_mobile/widgets/header_container.dart';
import 'package:voting_system_mobile/widgets/list_card.dart';
import 'package:voting_system_mobile/widgets/progress_hud_modal.dart';
import 'package:voting_system_mobile/widgets/text_input_container.dart';
import 'package:voting_system_mobile/screens/select_role_screen.dart';

class SelectOrganization extends StatefulWidget {
  static const String id = 'select_organization';
  final String userId;

  SelectOrganization({@required this.userId});

  @override
  _SelectOrganizationState createState() => _SelectOrganizationState();
}

class _SelectOrganizationState extends State<SelectOrganization> {
  List organizations = [];
  bool inAsynchCall = true;

  @override
  void initState() {
    // fetch organizations list
    RequestService().fetchOrganizations().then((response) {
      organizations.addAll(response);
      print(organizations.first.organizationId);
      setState(() {
        inAsynchCall = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uiSetup(context), inAsynchCall: inAsynchCall);
  }

  Widget _uiSetup(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HeaderContainer(
                queryHeight: 0.25,
                title: 'Where do you work?',
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                  child: Column(
                    children: <Widget>[
                      TextInput(
                        icon: Icons.search_sharp,
                        onChanged: (input){
                          // Todo: implement search functionality here
                        },
                        hintText: 'Search from Organizations',
                        textInputType: TextInputType.text,
                        controller: searchController,
                      ),
                      SizedBox(height: 10.0),
                      Divider(height: 2.0, thickness: 2.0),
                      SizedBox(height: 10.0),
                      for (var organization in organizations)
                        ListCard(
                            objectId: organization.organizationId,
                            objectName: organization.organizationName,
                            userId: widget.userId,
                          onPressed: (){
                            showDialog(context: context, builder: (BuildContext context) => ShowAlertDialog(organizationName: organization.organizationName)).then((value){
                              if (value == true){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SelectRole(userId: widget.userId, organizationId: organization.organizationId)));
                              }
                            });
                          },
                        )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
