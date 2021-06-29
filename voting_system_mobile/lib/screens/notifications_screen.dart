import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/utils/app_url.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  IO.Socket _socket;
  String message;

  @override
  void initState() {
    super.initState();
    initSocketIo();
  }

  void initSocketIo() {
    var userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      // connect client to socket
      _socket = IO.io(
        "${AppUrl.socketIo}",
        <String, dynamic>{
          'transports': ['websocket']
        },
      );

      _socket.connect();

      _socket.onConnect((_) {
        print('connect');
        // emit authentication event
        var authenticationJson = {
          "userId": userProvider.userId,
          "accesstoken": userProvider.token
        };

        _socket.emit(
          "authentication",
          authenticationJson,
        );

        // receive incoming message
        _socket.on("Notification", (greetData) {
          print("Greeting: ${greetData.toString()}");
          setState(() {
            message = greetData.toString();
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Is socket connected: $message"),
      ),
    );
  }
}
