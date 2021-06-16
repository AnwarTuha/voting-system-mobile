import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:voting_system_mobile/providers/connection_provider.dart';

class ConnectivityService {
  StreamController<ConnectionStatus> connectionStatusController =
      StreamController<ConnectionStatus>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  ConnectionStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectionStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectionStatus.Wifi;
      case ConnectivityResult.none:
        return ConnectionStatus.Offline;
      default:
        return ConnectionStatus.Offline;
    }
  }
}
