import 'package:flutter/material.dart';

class NotificationCounterProvider extends ChangeNotifier {
  int counter = 0;

  int get getCounter => counter;

  void setCounter(int addToCounter) {
    counter += addToCounter;
    notifyListeners();
  }
}
