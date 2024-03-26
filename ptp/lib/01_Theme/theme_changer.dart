import 'package:flutter/material.dart';

var darkTheme = ThemeData.dark();
var lightTheme= ThemeData.light();

class ThemeChanger extends ChangeNotifier {
  ThemeData _themeData;
  ThemeChanger(this._themeData);

  // Color _currentColor = const Color(0xff443a49);
  Color _currentColor = Colors.black;
  get getTheme => _themeData;
  void setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  get getColor => _currentColor;
  void setColor(Color pickedColor){
    _currentColor = pickedColor;
    notifyListeners();
  }
}