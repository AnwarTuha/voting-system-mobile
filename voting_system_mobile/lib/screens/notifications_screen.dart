import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:voting_system_mobile/utils/app_url.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  IO.Socket _socket;

  @override
  void initState() {
    super.initState();
    connectIO();
  }

  void connectIO() async {
    _socket = IO.io(
      '${AppUrl.socketIo}',
      <String, dynamic>{
        'transports': ['websocket']
      },
    );

    _socket.onConnect((data) {
      print("connected");
    });
    _socket.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Is socket connected: ${_socket.connected}"),
      ),
    );
  }
}
