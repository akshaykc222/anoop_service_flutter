import 'package:flutter/material.dart';

class DashBoardProvider with ChangeNotifier {
  bool isOpen = false;

  get popupOpen => isOpen;

  void setPopupOpen() {
    isOpen = !isOpen;
    notifyListeners();
  }
}
