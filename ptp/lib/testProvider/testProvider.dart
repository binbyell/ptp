
import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {
  String _textData = "";
  double _count = 0;

  String get getTextData => _textData;
  void setTextData(String text){
    _textData = text;
    _count += 10;
    notifyListeners();
  }
  double get getCount => _count;
}