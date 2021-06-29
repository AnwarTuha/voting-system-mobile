import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/providers/connection_provider.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final double opacity;

  NetworkSensitive({this.opacity = 0.5, this.child});

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectionStatus>(context);

    if (connectionStatus == ConnectionStatus.Wifi ||
        connectionStatus == ConnectionStatus.Cellular) {
      return child;
    }

    return Container(
      child: Center(
        child: Text("No connection could be established"),
      ),
    );
  }
}
