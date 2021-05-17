import 'package:flutter/material.dart';
import 'package:voting_system_mobile/classes/request_service.dart';
import 'package:voting_system_mobile/widgets/alert_dialog.dart';
import 'package:voting_system_mobile/widgets/header_container.dart';
import 'package:voting_system_mobile/widgets/list_card.dart';
import 'package:voting_system_mobile/widgets/text_input_container.dart';
import 'package:voting_system_mobile/model/roles_model.dart';

class SelectRole extends StatefulWidget {

  static const String id = 'select_role';
  final String userId;
  final String organizationId;

  SelectRole({this.userId, this.organizationId});

  @override
  _SelectRoleState createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {

  List roles = [];

  @override
  void initState() {

    print(widget.organizationId);

    RoleRequestModel roleRequestModel = RoleRequestModel();

    roleRequestModel.orgId = widget.organizationId;

    RequestService().fetchRoles(roleRequestModel).then((value){
      print(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HeaderContainer(
                queryHeight: 0.25,
                title: 'What is your role?',
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                  child: Column(
                    children: <Widget>[
                      TextInput(
                        icon: Icons.search_sharp,
                        controller: searchController,
                        onChanged: (input){
                          // Todo: implement search
                        },
                        hintText: 'Search roles',
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(height: 10.0),
                      Divider(thickness: 2.0, height: 2.0),
                      SizedBox(height: 10.0),
                      for (var role in roles)
                        ListCard(
                          userId: widget.userId,
                          objectId: role['id'],
                          objectName: role['name'],
                          onPressed: (){
                            showDialog(context: context, builder: (BuildContext context) => ShowAlertDialog(organizationName: role['name'])).then((value){
                              if (value == true){

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
