import 'package:flutter/material.dart';

class PurchaseCount extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void incrementCount() {
    _count++;
    notifyListeners(); 
  }
}