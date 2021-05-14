import 'package:flutter/material.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/widgets/header_container.dart';
import 'package:voting_system_mobile/widgets/organization_card.dart';
import 'package:voting_system_mobile/widgets/progress_hud_modal.dart';
import 'package:voting_system_mobile/widgets/text_input_container.dart';

class SelectOrganization extends StatefulWidget {
  static const String id = 'select_organization';

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
                        OrganizationCard(
                            organizationId: organization.organizationId,
                            organizationName: organization.organizationName)
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
