
import 'package:flutter/material.dart';

class BottomNavigationBarProvider extends ChangeNotifier {
 
  int _currentTabIndex = 0;

  // Returns the current tab's index
 int  get currentTabIndex => _currentTabIndex;

  // Sets the current tab's index
  set setCurrentTabIndex(int newIndex) {
    _currentTabIndex = newIndex;
    notifyListeners();
  }
}