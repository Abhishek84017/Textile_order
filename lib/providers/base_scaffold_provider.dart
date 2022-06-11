import 'package:flutter/material.dart';

class BaseScaffoldProvider extends ChangeNotifier {
  int _currentBottomBarIndex = 0;

  int get currentBottomBarIndex => _currentBottomBarIndex;

  VoidCallback? callback;

  set changeIndex(int index) {
    if (_currentBottomBarIndex != index) {
      _currentBottomBarIndex = index;
      notifyListeners();
    } else if (callback != null && _currentBottomBarIndex == index) {
      callback?.call();
    }
  }
}
