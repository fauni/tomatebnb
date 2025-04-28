
import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier{
  int _selectedIndex = 0;
  int _selectedIndexAnfitrion = 0;

  int get selectedIndex => _selectedIndex;
  int get selectedIndexAnfitrion => _selectedIndexAnfitrion;

  setPage(int index){
    _selectedIndex = index;
    notifyListeners();
  }

  setPageAnfitrion(int index){
    _selectedIndexAnfitrion = index;
    notifyListeners();
  }
}

