import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_util.dart';
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

    void filterSearchResults(String query){
      List<String> dummySearchList = [];
      dummySearchList.addAll(duplicateItems);
      if (query.isNotEmpty){
        dummySearchList.forEach((item) {
          if (item.contains(query)){
            dummySearchList.add(item);
          }
        });
        setState(() {
          items.clear();
          items.addAll(dummySearchList);
        });
        return;
      } else {
        setState(() {
          items.clear();
          items.addAll(duplicateItems);
        });
      }
    }

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
                child: Column(
                  children: <Widget>[
                    TextField(
                      onChanged: (query){
                        filterSearchResults(query);
                      },
                      controller: editingController,
                      decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefix: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: tealColors),
                        )
                      ),
                    ),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('${items[index]}'),
                          );
                        }
                    ),
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
