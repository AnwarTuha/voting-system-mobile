import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';
import 'package:voting_system_mobile/widgets/header_container.dart';

class SelectOrganization extends StatefulWidget {

  static const String id = 'select_organization';

  @override
  _SelectOrganizationState createState() => _SelectOrganizationState();
}

class _SelectOrganizationState extends State<SelectOrganization> {

  final duplicateItems = List<String>.generate(20, (i) => "Item $i");

  List items = [];

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController editingController = TextEditingController();

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
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      onChanged: (query){
                        // Todo: filter organizations based on query
                      },
                      controller: editingController,
                      decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefix: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: tealColors),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                        )
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Card(
                      color: Colors.white,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Orange Digital Center',
                              style: TextStyle(fontSize: 18.0, color: Colors.black),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 25.0,
                              color: tealColors,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
