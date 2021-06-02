import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class NavigationDrawer extends StatelessWidget {

  final padding = EdgeInsets.symmetric(horizontal: 20.0);

  @override
  Widget build(BuildContext context) {

    final _firstName = Provider.of<UserProvider>(context).user.firstName;
    final _lastName = Provider.of<UserProvider>(context).user.lastName;
    final _email = Provider.of<UserProvider>(context).user.email;

    return Drawer(
      child: Material(
        color: Color.alphaBlend(tealColors, tealLightColor),
        child: ListView(
          children: <Widget>[
            buildHeader(
                profilePicWidget: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage("assets/images/temp_profile.jpg"),
                ),
                firstName: _firstName,
                lastName: _lastName,
                email: _email
            ),
            Container(
              padding: padding,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 15.0),
                  buildMenuItem(
                      title: 'Live Polls',
                      icon: Icons.wifi_tethering,
                      onPressed: () => selectedItem(context, 0)
                  ),
                  const SizedBox(height: 16.0),
                  buildMenuItem(
                      title: 'Pending Polls',
                      icon: Icons.pending,
                      onPressed: () => selectedItem(context, 1)
                  ),
                  const SizedBox(height: 16.0),
                  buildMenuItem(
                      title: 'Poll Results',
                      icon: Icons.poll,
                      onPressed: () => selectedItem(context, 2)
                  ),
                  const SizedBox(height: 24.0),
                  Divider(color: Colors.white),
                  const SizedBox(height: 24.0),
                  buildMenuItem(
                      title: 'Home',
                      icon: Icons.home,
                      onPressed: () => selectedItem(context, 3)
                  ),
                  const SizedBox(height: 16.0),
                  buildMenuItem(
                      title: 'Notifications',
                      icon: Icons.notifications_active,
                      onPressed: () => selectedItem(context, 4)
                  ),
                  const SizedBox(height: 16.0)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    @required Widget profilePicWidget,
    @required String firstName,
    @required String lastName,
    @required String email,
    Function onPressed,
  }) => InkWell(
    onTap: onPressed,
    child: Container(
      padding: padding.add(EdgeInsets.symmetric(vertical: 40.0)),
      child: Row(
        children: <Widget>[
          profilePicWidget,
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("$firstName $lastName", style: TextStyle(fontSize: 20.0, color: Colors.white)),
              const SizedBox(height: 4.0),
              Text(email, style: TextStyle(fontSize: 14.0, color: Colors.white)),
            ],
          ),
          Spacer(),
          Expanded(
            child: Icon(Icons.edit, color: Colors.grey)
          )
        ],
      ),
    ),
  );

  Widget buildMenuItem({@required String title, @required IconData icon, Function onPressed}){
    final color = Colors.white;

    return ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(color: color)),
        onTap: onPressed,
    );

  }

  void selectedItem(BuildContext context, int index){

    Navigator.pop(context);

    switch(index){
      case 0:
        print(index);
        break;
      case 1:
        print(index);
        break;
      case 2:
        print(index);
        break;
      case 3:
        print(index);
        break;
      case 4:
        print(index);
        break;
      case 5:
        print(index);
        break;
    }
  }

}
