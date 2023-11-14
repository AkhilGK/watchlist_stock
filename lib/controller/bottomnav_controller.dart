import 'package:flutter/material.dart';

class BottomnavController extends ChangeNotifier {
  int selctedIndex = 0;
  void onChange(int index) {
    selctedIndex = index;
    notifyListeners();
  }
}
